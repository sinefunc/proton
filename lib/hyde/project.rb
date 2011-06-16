class Hyde
# A project.
#
# Instanciating:
#
#   project = Project.new('~/spur')
#   project == Hyde.project          # the last defined project
#
# Building:
#
#   project.build
#   project.build { |file| puts "Building #{file}..." }
#
# Getting pages:
#
#   Hyde::Page['/index.html']        # ~/spur/index.md; uses Hyde.project
#
# Configuration:
#
#   project.config_file              # ~/spur/hyde.conf
#   project.config                   # Config from above file (OpenStruct)
#   project.config.site_path
#
# Paths:
#
#   project.path(:site)              # ~/spur/site (based on config site_path)
#   project.path(:extensions)
#
#   project.root('a/b', 'c')         # ~/spur/a/b/c
#
# Indexing:
#
#   project.pages                    # [<#Page>, <#Page>, ...]
#   project.files                    # ['/index.md', '/style.sass', ...]
#                                    # (only site files)
#   project.ignored_files
#
class Project
  def initialize(root=Dir.pwd)
    @root = root
    Hyde.project = self

    validate_version
    load_extensions

    require 'hyde/compass_support'
  end

  def validate_version
    return unless config_file?
    req = config.hyde_requirement.to_s

    v = lambda { |version| Gem::Version.new version }

    if req.empty?
      # pass
    elsif v[req] < v["0.1"]
      raise LegacyError, "This is a legacy project"
    elsif v[req] > v[Hyde.version]
      raise VersionError, "You will need Hyde version >= #{req} for this project."
    end
  end

  def load_extensions
    path = path(:extensions)

    ( Dir[path(:extensions, '*.rb')] +
      Dir[path(:extensions, '*', '*.rb')]
    ).sort.each { |f| require f }  if path
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

    # Ignore the standard files
    [:layouts, :extensions, :partials, :output].each do |aspect|
      specs << File.join(config.send(:"#{aspect}_path"), '**/*') if path(aspect) && path(aspect) != path(:site)
    end

    # Ignore dotfiles and hyde.conf by default
    specs += %w[.* _* *~ README* /hyde.conf /config.ru]

    specs.compact.map { |s| glob(s) }.flatten.uniq
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
  def glob(str)
    if str[0] == '/'
      Dir[str] + Dir[root(str)] + Dir["#{root(str)}/**"]
    else
      Dir[root("**/#{str}")] + Dir[root("**/#{str}/**")]
    end
  end

  def build_cleanup
    FileUtils.rm_rf '.sass_cache'
  end
end
end

