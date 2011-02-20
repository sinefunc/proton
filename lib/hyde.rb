$:.push *Dir[File.expand_path('../../vendor/*/lib', __FILE__)]

gem 'shake', '~> 0.1'

require 'fileutils'
require 'ostruct'
require 'yaml'
require 'tilt'
require 'shake'

class Hyde
  VERSION = "0.1.1"
  PREFIX  = File.expand_path('../', __FILE__)

  Error        = Class.new(StandardError)
  LegacyError  = Class.new(Error)
  VersionError = Class.new(Error)
  NoGemError   = Class.new(Error)

  autoload :Project, "#{PREFIX}/hyde/project"
  autoload :Page,    "#{PREFIX}/hyde/page"
  autoload :Meta,    "#{PREFIX}/hyde/meta"
  autoload :Config,  "#{PREFIX}/hyde/config"
  autoload :CLI,     "#{PREFIX}/hyde/cli"
  autoload :Layout,  "#{PREFIX}/hyde/layout"
  autoload :Partial, "#{PREFIX}/hyde/partial"
  autoload :Helpers, "#{PREFIX}/hyde/helpers"

  def self.version
    VERSION
  end
end
