class Hyde
class Page
  attr_reader :project
  attr_reader :file

  # Returns the URL path for a page.
  def path
    path = @file.sub(root_path, '')

    # if xx.haml (but not xx.html.haml), 
    if tilt?
      path = path.sub(/\.[^\.]*$/, "")
      path += ".#{default_ext}"  unless File.basename(path).include?('.')
    end

    path
  end

  def title
    meta.title || path
  end

  alias to_s title

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

  def self.[](id, project=$project)
    site = lambda { |*x| File.join root_path(project), *(x.compact) }
    try  = lambda { |id| p = new(id, project); p if p.exists? }

    # Account for:
    #   ~/mysite/site/about/us.html.haml
    #   about/us.html.haml => ~/mysite/site/about/us.html.haml
    #   about/us.html      => ~/mysite/site/about/us.html.*
    #   about/us.html      => ~/mysite/site/about/us.*
    #   about/us           => ~/mysite/site/about/us/index.*
    #
    page   = try[id]
    page ||= try[site[id]]
    page ||= try[Dir[site["#{id}.*"]].first]
    page ||= try[Dir[site["#{id.to_s.sub(/\.[^\.]*/,'')}.*"]].first]
    page ||= try[Dir[site[id, "index.*"]].first]

    # Subclass
    if page && page.tilt? && page.meta.type
      klass = Page.get_type(page.meta.type)
      raise Error, "Class for type '#{page.meta.type}' not found"  unless klass
      page = klass.new(id, project)
    end
    page
  end

  # Returns a page subtype.
  # @example Page.get_type('post') => Hyde::Page::Post
  def self.get_type(type)
    klass = type[0].upcase + type[1..-1].downcase
    klass = klass.to_sym
    self.const_get(klass)  if self.const_defined?(klass)
  end

  def initialize(file, project=$project)
    @file = file
    @project = project
    raise Error  if project.nil?
  end

  def exists?
    @file and File.file?(@file) and valid?
  end

  # Make sure that it's in the right folder.
  def valid?
    prefix = File.expand_path(root_path)
    prefix == File.expand_path(@file)[0...prefix.size]
  end

  def to_html(locals=nil, &blk)
    scope = self.dup
    scope.extend Helpers
    html = tilt? ? tilt.render(scope, &blk) : markup
    html = layout.to_html { html }  if layout?
    html
  end

  def layout
    layout = meta.layout
    layout ||= default_layout  unless meta.layout == false
    Layout[layout]  if layout
  end

  def layout?
    !! layout
  end

  def meta
    @meta ||= OpenStruct.new(YAML::load(parts.first))
  end

  # Writes to the given output file.
  def write(out=nil)
    out ||= project.path(:output, path)
    FileUtils.mkdir_p File.dirname(out)

    if tilt?
      File.open(out, 'w') { |f| f.write to_html }
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
  def tilt
    if tilt?
      # HAML options and such (like :escape_html)
      options = project.config.tilt_options_for(@file)
      offset = parts.first.count("\n") + 2
      @tilt ||= Tilt.new(@file, offset, options) { markup }
    end
  end

  def markup
    parts.last
  end

  def method_missing(meth, *args, &blk)
    super  unless meta.instance_variable_get(:@table).keys.include?(meth.to_sym)
    meta.send(meth)
  end

  def page
    self
  end

  def parent
    parts = path.split('/')
    parent_path = index? ? parts[0...-2] : parts[0...-1]
    self.class[parent_path.join('/'), project]
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

    Dir[files].reject { |f| f == @file }.map { |f| self.class[f, project] }.compact.sort
  end

  def siblings
    p = parent and p.children
  end

  def breadcrumbs
    parent? ? (parent.breadcrumbs + [self]) : [self]
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

protected
  def default_layout
    'default'  if html?
  end

  # Returns the two parts of the markup.
  def parts
    @parts ||= begin
      t = File.open(@file).read.force_encoding('UTF-8')
      m = t.match(/^(.*)--+\n(.*)$/m)
      m.nil? ? ['', t] : [m[1], m[2]]
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
