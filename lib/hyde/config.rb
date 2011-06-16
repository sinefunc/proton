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
class Config
  DEFAULTS = {
    :site_path => '.',
    :layouts_path => '_layouts',
    :extensions_path => '_extensions',
    :partials_path => '_layouts',
    :output_path => '_output',
    :tilt_options => {
      :haml => {
        :escape_html => true
      },
      :sass => {
        :load_paths => ['css', '.'],
        :style => :compact,
        :line_numbers => true
      },
      :scss => {
        :load_paths => ['css', '..'],
        :style => :compact,
        :line_numbers => true
      },
    },
    :tilt_build_options => {
      :scss => {
        :style => :compressed,
        :line_numbers => false
      },
      :sass => {
        :style => :compressed,
        :line_numbers => false
      }
    }
  }

  def self.load(config_file)
    new(YAML::load_file(config_file)) rescue new
  end

  def initialize(options={})
    # Try to emulate proper .merge behavior in Ruby 1.8
    #DEFAULTS.each { |k, v| options[k] ||= v }
    @table = Hashie::Mash.new
    @table.deep_merge! DEFAULTS
    @table.deep_merge! options
  end

  # Passthru
  def method_missing(meth, *args, &blk)
    @table.send meth, *args
  end

  # Returns tilt options for a given file.
  # @example tilt_options('index.haml')  # { :escape_html => ... }
  def tilt_options_for(file, options={})
    ext = file.split('.').last.downcase
    opts = tilt_options(ext) || Hash.new
    opts = opts.merge(tilt_options(ext, :tilt_build_options))  if options[:build]

    to_hash opts
  end

  # Returns tilt options for a given engine.
  # @example tilt_options('haml')  # { :escape_html => ... }
  def tilt_options(what, key=:tilt_options)
    @table[key] ||= Hash.new
    @table[key][what.to_s] ||= Hash.new
  end

private
  def to_hash(mash)
    mash.inject(Hash.new) { |h, (k, v)| h[k.to_sym] = v; h } 
  end
end
end
