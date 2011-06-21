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

# Class: Proton
# The Proton class.
#
# ## Description
#    This is the main class.
#
#    This class is also aliased as `Hyde` for backward-compatibility with
#    versions <= 0.2.x, when the project was still called Hyde.

class Proton
  PREFIX  = File.expand_path('../', __FILE__)

  # Class: Proton::Error 
  # An error.
  #
  # ## Description
  #    The class Error describes any error thrown by the application.
  #
  # ##  Example
  #
  #     begin
  #       Proton::Project.new './my_project/'
  #     rescue Proton::LegacyError => e
  #       puts "Old version."
  #     rescue Proton::VersionError => e
  #       puts "The project requires a newer version of Proton."
  #     rescue Proton::Error => e
  #       puts e
  #     end

  Error        = Class.new(StandardError)
  LegacyError  = Class.new(Error)
  VersionError = Class.new(Error)

  # Constant: CONFIG_FILES (Proton)
  # An array of the allowed config filenames.
  CONFIG_FILES = ['Protonfile', 'proton.conf', '.protonrc', 'hyde.conf', '.hyderc']

  autoload :Project, "#{PREFIX}/proton/project"
  autoload :Page,    "#{PREFIX}/proton/page"
  autoload :Meta,    "#{PREFIX}/proton/meta"
  autoload :Config,  "#{PREFIX}/proton/config"
  autoload :CLI,     "#{PREFIX}/proton/cli"
  autoload :Set,     "#{PREFIX}/proton/set"
  autoload :Layout,  "#{PREFIX}/proton/layout"
  autoload :Partial, "#{PREFIX}/proton/partial"
  autoload :Helpers, "#{PREFIX}/proton/helpers"

  require "#{PREFIX}/proton/version"

  class << self
    # Attribute: project (Proton)
    # Returns the latest project.
    #
    # ##  Example
    #     Proton.project.path(:site)

    attr_accessor :project
  end
end

# For backward compatibility reasons, Hyde is an alias for Proton.
Hyde = Proton
