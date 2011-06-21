require 'compass'

opts = Compass.sass_engine_options

[:sass, :scss].each do |type|
  Proton.project.config.tilt_options(type)[:load_paths] ||= Array.new
  Proton.project.config.tilt_options(type)[:load_paths] += opts[:load_paths]
end
