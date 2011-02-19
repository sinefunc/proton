class Hyde
class Config < OpenStruct
  DEFAULTS = {
    :site_path => '.',
    :layouts_path => 'layouts',
    :extensions_path => 'extensions',
    :partials_path => 'partials',
    :output_path => 'public'
  }

  def self.load(config_file)
    new(YAML::load_file(config_file)) rescue new
  end

  def initialize(options={})
    super DEFAULTS.merge(options)
  end
end
end
