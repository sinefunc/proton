$:.push File.expand_path('../../lib', __FILE__)

require 'rubygems'  if !Object.respond_to?(:gem)

gem "contest", "~> 0.1"

require 'hyde'
require 'contest'

class TestCase < Test::Unit::TestCase
  # Shorthand
  Page    = Hyde::Page
  Project = Hyde::Project

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

class Hyde::Set
  # Because 1.8.6 doesn't support map(&:path)
  def paths
    map { |page| page.path }
  end
end
