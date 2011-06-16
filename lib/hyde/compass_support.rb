require 'compass'

opts = Compass.sass_engine_options

[:sass, :scss].each do |type|
  Hyde.project.config.tilt_options(type)[:load_paths] ||= Array.new
  Hyde.project.config.tilt_options(type)[:load_paths] += opts[:load_paths]
end
