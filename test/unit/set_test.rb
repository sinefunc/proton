require File.expand_path('../../helper', __FILE__)

class SetTest < TestCase
  setup do
    @path = fixture('one')
    @project = Project.new(@path)
    Dir.chdir @path
  end

  test "breadcrumbs" do
    assert Page['/about/index.css'].breadcrumbs.is_a?(Hyde::Set)
  end

  test "children" do
    assert Page['/'].children.is_a?(Hyde::Set)
  end

  test "siblings" do
    assert Page['/about'].siblings.is_a?(Hyde::Set)
  end

  test "children" do
    set = Page['/'].children.find(:hello => 'world')
    assert set.paths == ['/hello.html']
  end
end
