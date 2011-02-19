class Hyde
class Config < OpenStruct
  DEFAULTS = {
    :site_path => 'site',
    :layouts_path => 'layouts',
    :extensions_path => 'extensions',
    :partials_path => 'partials',
    :output_path => 'public'
  }
  def self.load(config_file)
    new YAML::load_file(config_file)
  end

  def initialize(*a)
    super *a
    @table ||= DEFAULTS
  end
end
end
