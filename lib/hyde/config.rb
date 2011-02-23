class Hyde
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
  def tilt_options_for(file)
    tilt_options file.split('.').last.downcase
  end

  # Returns tilt options for a given engine.
  # @example tilt_options('haml')  # { :escape_html => ... }
  def tilt_options(what)
    @tilt_options ||= begin
      o = @table[:tilt_options] || Hash.new
      o['haml'] ||= { :escape_html => true }
      o['scss'] ||= { :load_path => ['css'] }
      o['sass'] ||= { :load_path => ['css'] }
      o
    end

    @tilt_options[what.to_s]
  end
end
end
