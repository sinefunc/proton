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

  alias to_s path

  def mime_type
    return tilt_engine.default_mime_type  if tilt?
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
    page ||= try[Dir[site["#{id.sub(/\.[^\.]*/,'')}.*"]].first]
    page ||= try[Dir[site[id, "index.*"]].first]
  end

  def initialize(file, project=$project)
    @file = file
    @project = project
    raise Error  if project.nil?
  end

  def exists?
    @file and File.file?(@file)
  end

  def to_html(locals=nil, &blk)
    tilt? ? tilt.render(locals, &blk) : markup
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
    @tilt ||= Tilt.new(@file) { markup }  if tilt?
  end

  def markup
    parts.last
  end

protected
  def parts
    t = File.open(@file).read.force_encoding('UTF-8')
    m = t.match(/^(.*)--+\n(.*)$/m)
    m.nil? ? ['', t] : [m[1], m[2]]
  end

  def self.root_path(project, *a)
    project.path(:site, *a)
  end

  def root_path(*a)
    self.class.root_path(*a)
  end
end
end
