# This file exists to make this project Rack-compatible.
# You may delete it if you're not concerned about this.

require 'hyde'
require 'hyde/server'

Hyde::Project.new File.dirname(__FILE__)
run Hyde::Server
