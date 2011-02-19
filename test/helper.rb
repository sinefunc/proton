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

  def build(path)
    @project = Hyde::Project.new(path)
    @project.pages.each { |p| p.write }
    @project
  end

  def unbuild(project=@project)
    FileUtils.rm_rf project.path(:output)
  end
end
