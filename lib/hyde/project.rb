class Hyde
class Project
  def initialize(root=Dir.pwd)
    @root = root
    $project = self
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
    root config.send(:"#{what}_path"), *a
  end

  def root(*args)
    File.join @root, *(args.compact)
  end

  def pages
    files.map { |f| Page[f, self] }.compact
  end

  def files
    Dir[File.join(path(:site), '**', '*')] - ignored_files
  end

  def ignored_files
    specs  = [*config.ignored_files]
    specs << path(:layouts,    '**/*')
    specs << path(:extensions, '**/*')
    specs << path(:partials,   '**/*')
    specs << path(:output,     '**/*')
    specs << config_file
    specs.compact.map { |s| Dir[s] }.flatten.uniq
  end

protected
  def write(path, output)
  end
end
end

