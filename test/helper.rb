$:.push File.expand_path('../../lib', __FILE__)

require 'hyde'
require 'contest'

# Unpack
Page    = Hyde::Page
Project = Hyde::Project

class TestCase < Test::Unit::TestCase
  def fixture(*a)
    path = File.expand_path('../fixture', __FILE__)
    File.join path, *a
  end
end
