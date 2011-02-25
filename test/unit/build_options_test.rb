
require File.expand_path('../../helper', __FILE__)

class BuildOptionsTest < TestCase
  setup do
    @path = fixture('build_options')
    @project = Project.new(@path)
    Dir.chdir @path
  end

  test "yada" do
    raw   = Page['/style.css'].to_html
    built = Page['/style.css'].to_html({}, :build => true)

    assert !built.include?("line 1")
    assert raw.include?("line 1")
  end
end
