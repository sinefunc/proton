class Hyde
class Project
  def initialize(root=Dir.pwd)
    @root = root
    $project = self

    validate_version
    load_extensions
  end

  def validate_version
    return unless config_file?
    req = config.hyde_requirement.to_s
    if req.empty?
    elsif req < "0.1"
      raise LegacyError, "This is a legacy project"
    elsif req > Hyde.version
      raise VersionError, "You will need Hyde version >= #{req} for this project."
    end
  end

  def load_extensions
    path = path(:extensions)
    Dir[path(:extensions, '*', '*.rb')].each { |f| require f }  if path
  end

  def config_file
    try = lambda { |path| p = root(path); p if File.file?(p) }
    try['hyde.conf'] || try['.hyderc']
  end

  def config_file?
    config_file
  end

  def config
    @config ||= Config.load(config_file)
  end

  # Returns the path for a certain aspect.
  # @example path(:site)
  def path(what, *a)
    return nil unless [:output, :site, :layouts, :extensions, :partials].include?(what)
    path = config.send(:"#{what}_path")
    root path, *a  if path
  end

  def root(*args)
    File.join @root, *(args.compact)
  end

  def pages
    files.map { |f| Page[f, self] }.compact
  end

  def files
    files = Dir[File.join(path(:site), '**', '*')]
    files = files.select { |f| File.file?(f) }
    files = files.map { |f| File.expand_path(f) }
    files - ignored_files
  end

  def ignored_files
    specs  = [*config.ignore].map { |s| root(s) }
    specs << config_file
    [:layouts, :extensions, :partials, :output].each do |aspect|
      specs << path(aspect, '**/*') if path(aspect) && path(aspect) != path(:site)
    end
    specs.compact.map { |s| Dir[s] }.flatten.uniq
  end

  def build(&blk)
    pages.each do |page|
      yield page
      page.write
    end
  ensure
    build_cleanup
  end

protected
  def build_cleanup
    FileUtils.rm_rf '.sass_cache'
  end
end
end

