$:.push *Dir[File.expand_path('../../vendor/*/lib', __FILE__)]

require 'fileutils'
require 'ostruct'
require 'hashie'
require 'yaml'
require 'tilt'
require 'shake'

# For Compass and such
Encoding.default_external = 'utf-8' if defined?(::Encoding)

# HTML files as ERB
Tilt.mappings['html'] = Tilt.mappings['erb']

class Hyde
  VERSION = "0.2.0"
  PREFIX  = File.expand_path('../', __FILE__)

  Error        = Class.new(StandardError)
  LegacyError  = Class.new(Error)
  VersionError = Class.new(Error)

  # Allowed config filenames
  CONFIG_FILES = ['hyde.conf', '.hyderc']

  autoload :Project, "#{PREFIX}/hyde/project"
  autoload :Page,    "#{PREFIX}/hyde/page"
  autoload :Meta,    "#{PREFIX}/hyde/meta"
  autoload :Config,  "#{PREFIX}/hyde/config"
  autoload :CLI,     "#{PREFIX}/hyde/cli"
  autoload :Set,     "#{PREFIX}/hyde/set"
  autoload :Layout,  "#{PREFIX}/hyde/layout"
  autoload :Partial, "#{PREFIX}/hyde/partial"
  autoload :Helpers, "#{PREFIX}/hyde/helpers"

  class << self
    # The latest project.
    attr_accessor :project

    def version
      VERSION
    end
  end
end
