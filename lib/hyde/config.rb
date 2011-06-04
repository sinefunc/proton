class Hyde
# Configuration.
#
# == Common usage
#
#   Hyde.project.config
#   Hyde.project.config.tilt_options('sass')[:load_path]
#
#   Hyde.project.config.site_path
#   Hyde.project.config.layouts_path
#
class Config < OpenStruct
  DEFAULTS = {
    :site_path => '.',
    :layouts_path => nil,
    :extensions_path => nil,
    :partials_path => nil,
    :output_path => nil
  }

  def self.load(config_file)
    new(YAML::load_file(config_file)) rescue new
  end

  def initialize(options={})
    # Try to emulate proper .merge behavior in Ruby 1.8
    options.each { |k, v| options[k] ||= DEFAULTS[k]  if DEFAULTS.keys.include?(k) }
    super options
  end

  # Returns tilt options for a given file.
  # @example tilt_options('index.haml')  # { :escape_html => ... }
  def tilt_options_for(file, options)
    ext = file.split('.').last.downcase
    opts = tilt_options(ext) || Hash.new
    opts = opts.merge(tilt_options(ext, :tilt_build_options) || Hash.new)  if options[:build]
    opts
  end

  # Returns tilt options for a given engine.
  # @example tilt_options('haml')  # { :escape_html => ... }
  def tilt_options(what, key=:tilt_options)
    @table[key] ||= begin
      h = Hash.new { |h, k| h[k] = Hash.new }
      h['haml'] = { :escape_html => true }
      h['scss'] = { :load_path => ['css'] }
      h['sass'] = { :load_path => ['css'] }
      h
    end

    @table[key][what.to_s] ||= Hash.new
  end
end
end
