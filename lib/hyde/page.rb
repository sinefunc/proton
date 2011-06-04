class Hyde
# A project.
#
# Getting pages from paths:
#
#   # Feed it a URL path, not a filename.
#   page = Hyde::Page['/index.html']        # uses Hyde.project
#   page = Hyde::Page['/index.html', project]
#
# Getting pages from files:
#
#   # Feed it a file name, not a URL path.
#   # Also, this does no sanity checks.
#   page = Hyde::Page.new('/home/rsc/index.html', project)
#
#   page.exists?
#   page.valid?
#
# Paths:
#
#   page.filepath          #=> "index.haml"    -- path in the filesystem
#   page.path              #=> "/index.html"   -- path as a RUL
#
# Meta:
#
#   page.meta              #=> OpenStruct of the metadata
#   page.title             #=> "Welcome to my site!"
#
#   page.layout            #   Hyde::Layout or nil
#   page.layout?
#
# Types:
#
#   page.html?
#   page.mime_type        #=> "text/html" or nil  -- only for tilt? == true
#   page.default_ext      #=> "html"
#
# Contents:
#
#   page.to_html
#   page.to_html(locals={})
#   page.content
#   page.markup
#
# Traversion:
#
#
#   # Pages (a Hyde::Page or nil)
#   page.parent
#   page.next
#
#   # Sets (a Hyde::Set)
#   page.children
#   page.siblings
#   page.breadcrumbs 
#
#   # Misc
#   page.index?            # if it's an index.html
#   page.parent?
#   page.root?             # true if no parents
#   page.depth
#
# Tilt:
#
#   page.tilt?             #   true, if it's a dynamic file
#   page.tilt_engine_name  #=> 'RedCloth'
# 
# Building:
#
#   page.write
#   page.write('~/foo.html')
#
class Page
  attr_reader :project
  attr_reader :file

  def self.[](id, project=Hyde.project)
    site_path = root_path(project)
    return nil  if site_path.nil?

    site = lambda { |*x| File.join site_path, *(x.compact) }
    try  = lambda { |_id| p = new(_id, project); p if p.exists? }

    # For paths like '/' or '/hello/'
    nonfile = File.basename(id).gsub('/','').empty?

    # Account for:
    #   ~/mysite/site/about/us.html.haml
    #   about/us.html.haml => ~/mysite/site/about/us.html.haml
    #   about/us.html      => ~/mysite/site/about/us.html.*
    #   about/us.html      => ~/mysite/site/about/us.*
    #   about/us           => ~/mysite/site/about/us/index.*
    #
    page   = try[id]
    page ||= try[site[id]]
    unless nonfile
      page ||= try[Dir[site["#{id}.*"]].first]
      page ||= try[Dir[site["#{id.to_s.sub(/\.[^\.]*/,'')}.*"]].first]
    end
    page ||= try[Dir[site[id, "index.*"]].first]

    # Subclass
    if page && page.tilt? && page.meta[:type]
      klass = Page.get_type(page.meta[:type])
      raise Error, "#{page.filepath}: Class for type '#{page.meta[:type]}' not found"  unless klass
      page = klass.new(id, project)
    end

    page
  end

  def initialize(file, project=Hyde.project)
    @file = File.expand_path(file)  if file.is_a?(String)
    @project = project
    raise Error  if project.nil?
  end

  # Returns the URL path for a page.
  def path
    path = @file.sub(File.expand_path(root_path), '')

    # if xx.haml (but not xx.html.haml), 
    if tilt?
      path = path.sub(/\.[^\.]*$/, "")
      path += ".#{default_ext}"  unless File.basename(path).include?('.')
    end

    path
  end

  # Returns a short filepath relative to the project path
  def filepath
    root = project.root
    fpath = file
    fpath = fpath[root.size..-1]  if fpath[0...root.size] == root
    fpath
  end

  def title
    (meta.title if tilt?) || path
  end

  alias to_s title

  def position
    meta[:position] || title
  end
  
  def <=>(other)
    result   = self.position <=> other.position
    result ||= self.position.to_s <=> other.position.to_s
    result
  end

  def html?
    mime_type == 'text/html'
  end

  def mime_type
    return nil  unless tilt?

    mime = nil
    mime = tilt_engine.default_mime_type  if tilt_engine.respond_to?(:default_mime_type)

    mime ||= case tilt_engine.name
      when 'Tilt::SassTemplate' then 'text/css'
      when 'Tilt::ScssTemplate' then 'text/css'
      when 'Tilt::LessTemplate' then 'text/css'
      when 'Tilt::CoffeeScriptTemplate' then 'application/javascript'
      when 'Tilt::NokogiriTemplate' then 'text/xml'
      when 'Tilt::BuilderTemplate' then 'text/xml'
      else 'text/html'
    end
  end

  def default_ext
    case mime_type
    when 'text/html' then 'html'
    when 'text/css' then 'css'
    when 'text/xml' then 'xml'
    when 'application/javascript' then 'js'
    end
  end

  # Returns a page subtype.
  # @example Page.get_type('post') => Hyde::Page::Post
  def self.get_type(type)
    type  = type.to_s
    klass = type[0..0].upcase + type[1..-1].downcase
    klass = klass.to_sym
    self.const_get(klass)  if self.const_defined?(klass)
  end

  def exists?
    @file and File.file?(@file||'') and valid?
  end

  # Make sure that it's in the right folder.
  def valid?
    prefix = File.expand_path(root_path)
    prefix == File.expand_path(@file)[0...prefix.size]
  end

  def content(locals={}, tilt_options={}, &blk)
    return markup  unless tilt?
    tilt(tilt_options).render(dup.extend(Helpers), locals, &blk)
  end

  def to_html(locals={}, tilt_options={}, &blk)
    html = content(locals, tilt_options, &blk)
    html = layout.to_html(locals, tilt_options) { html }  if layout?
    html
  end

  def layout
    layout = meta.layout
    layout ||= default_layout  unless meta.layout == false
    Layout[layout, page]  if layout
  end

  def page
    self
  end

  def layout?
    !! layout
  end

  def meta
    @meta ||= Meta.new(parts.first)
  end

  # Writes to the given output file.
  def write(out=nil)
    out ||= project.path(:output, path)
    FileUtils.mkdir_p File.dirname(out)

    if tilt?
      File.open(out, 'w') { |f| f.write to_html({}, :build => true) }
    else
      FileUtils.cp file, out
    end
  end

  # Checks if the file is supported by tilt.
  def tilt?
    !! tilt_engine
  end

  # Returns the Tilt engine (eg Tilt::HamlEngine).
  def tilt_engine
    Tilt[@file]
  end

  def tilt_engine_name
    tilt_engine.name.match(/:([^:]*)(?:Template?)$/)[1]
  end

  # Returns the tilt layout.
  def tilt(tilt_options={})
    if tilt?
      parts
      # HAML options and such (like :escape_html)
      options = project.config.tilt_options_for(@file, tilt_options)
      offset = @offset || 1
      Tilt.new(@file, offset, options) { markup }
    end
  end

  def markup
    parts.last
  end

  def method_missing(meth, *args, &blk)
    super  unless meta.instance_variable_get(:@table).keys.include?(meth.to_sym)
    meta.send(meth)
  end

  def parent
    parts = path.split('/') # ['', 'about', 'index.html']

    try = lambda { |newpath| p = self.class[newpath, project]; p if p && p.path != path }

    # Absolute root
    return nil  if index? and parts.size <= 2

    parent   = try[parts[0...-1].join('/')]  # ['','about'] => '/about'
    parent ||= try['/']                      # Home
  end

  def children
    files = if index?
      # about/index.html => about/*
      File.expand_path('../*', @file)
    else
      # products.html => products/*
      base = File.basename(@file, '.*')
      File.expand_path("../#{base}/*", @file)
    end

    Set.new Dir[files].reject { |f| f == @file }.map { |f| self.class[f, project] }.compact.sort
  end

  def siblings
    pages = (p = parent and p.children)
    return Set.new  unless pages
    return Set.new  unless pages.include?(self)
    Set.new(pages)
  end

  def breadcrumbs
    Set.new(parent? ? (parent.breadcrumbs + [self]) : [self])
  end
  
  def index?
    File.basename(path, '.*') == 'index'
  end

  def parent?
    !parent.nil?
  end

  def root?
    parent.nil?
  end

  def depth
    breadcrumbs.size
  end

  def next
    page = self
    while true do
      page.siblings.index(self)
    end
  end

  def ==(other)
    self.path == other.path
  end

  def inspect
    "<##{self.class.name} #{path.inspect}>"
  end

protected
  def default_layout
    'default'  if html?
  end

  # Returns the two parts of the markup.
  def parts
    @parts ||= begin
      t = File.open(@file).read
      t = t.force_encoding('UTF-8')  if t.respond_to?(:force_encoding)
      m = t.match(/^(.*?)\n--+\n(.*)$/m)

      if m.nil?
        [{}, t]
      else
        @offset = m[1].count("\n") + 2
        data = YAML::load(m[1])
        raise ArgumentError unless data.is_a?(Hash)
        [data, m[2]]
      end
    rescue ArgumentError
      [{}, t]
    end
  end

  def self.root_path(project, *a)
    project.path(:site, *a)
  end

  def root_path(*a)
    self.class.root_path(project, *a)
  end
end
end
