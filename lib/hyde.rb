$:.push *Dir[File.expand_path('../../vendor/*/lib', __FILE__)]

require 'fileutils'
require 'ostruct'
require 'yaml'
require 'tilt'

class Hyde
  VERSION = "0.1.0pre1"
  PREFIX  = File.expand_path('../', __FILE__)

  Error = Class.new(StandardError)

  autoload :Project, "#{PREFIX}/hyde/project"
  autoload :Page,    "#{PREFIX}/hyde/page"
  autoload :Config,  "#{PREFIX}/hyde/config"
  autoload :CLI,     "#{PREFIX}/hyde/cli"
  autoload :Layout,  "#{PREFIX}/hyde/layout"
  autoload :Helpers, "#{PREFIX}/hyde/helpers"
end
