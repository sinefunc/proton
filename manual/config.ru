begin
  require 'bundler'
  Bundler.setup
rescue LoadError => e
end

require 'proscribe'
run ProScribe.rack_app
