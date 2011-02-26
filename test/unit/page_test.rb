require File.expand_path('../../helper', __FILE__)

class PageTest < TestCase
  setup do
    @path = fixture('one')
    @project = Project.new(@path)
    Dir.chdir @path
  end

  test "root" do
    @page = Page['/']
    assert @page.index?
    assert @page.root?
  end

  test "breadcrumbs" do
    assert_equal %w(/index.html /about/index.css), Page['/about/index.css'].breadcrumbs.paths
    assert_equal %w(/index.html /about/index.css /about/us.html), Page['/about/us.html'].breadcrumbs.paths
    assert_equal %w(/index.html /css/style.css), Page['/css/style.css'].breadcrumbs.paths
    assert_equal %w(/index.html), Page['/'].breadcrumbs.paths
  end

  test "parent" do
    assert Page['/'].parent.nil?
    assert Page['/css/style.css'].parent.path == '/index.html'
  end

  test "siblings" do
    # Because it has no parent, technically
    page = Page['/about/index.css']
    assert page.siblings.empty?

    page = Page['/hello.html']
    assert_equal %w(/cheers.html /hello.html /hi.html), page.siblings.paths
  end

  test "mimes" do
    assert !Page['/css/style.css'].html?
    assert Page['/'].html?
    assert_equal 'text/css',  Page['/css/style.css'].mime_type
    assert_equal 'text/html', Page['/about/us.html'].mime_type
    assert_equal 'html', Page['/about/us.html'].default_ext
    assert_equal 'css',  Page['/css/style.css'].default_ext
  end

  test "no layout" do
    page = Page['/hi.html']
    assert_equal false, page.meta.layout
    assert_equal nil, page.layout
    assert_equal false, page.layout?
    assert_equal page.to_html, page.content
  end

  test "html pages should be intact" do
    page = Page['/hi']
    assert_equal page.markup, page.content
  end
end
