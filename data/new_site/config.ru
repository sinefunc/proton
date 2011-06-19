# This file exists to make this project Rack-compatible.
# You may delete it if you're not concerned about this.

if File.file?('Gemfile') && File.file?('Gemfile.lock')
  # Use Bundler to load hydeweb, if a Gemfile is around.
  require 'bundler'
  Bundler.setup
else
  # Else, just go Rubygems.
  require 'rubygems'  unless defined?(::Gem)
  gem 'hydeweb', '~> 0.2.0'
end

require 'hyde'
require 'hyde/server'

begin
  # Add the 'rack-cache' gem if you want to enable caching.
  require 'rack/cache'
  use Rack::Cache
rescue LoadError
  # pass
end

Hyde::Project.new File.dirname(__FILE__)
run Hyde::Server
