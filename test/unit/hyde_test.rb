require File.expand_path('../../helper', __FILE__)

class HydeTest < TestCase
  setup do
    @path = fixture('one')
    @project = Project.new(@path)
    Dir.chdir @path
  end

  test "hi" do
    #y @project.pages.map { |page| y html: page.to_html, path: page.path, file: page.file }
  end

  test "build" do
    @project.pages.each { |page| page.write }
  end

  test "accessible" do
    site = lambda { |*a| File.join(@path, 'site', *a) }

    # site/hi.html
    assert_equal Page['/cheers.html'].file,   site['cheers.html.haml']
    assert_equal Page['/hi.html'].file,       site['hi.html']
    assert_equal Page['/hi.yo'].file,         site['hi.html']
    assert_equal Page['/css/style.css'].file, site['css/style.scss']
    assert_equal Page['/css/style.css'].file, site['css/style.scss']
    assert_equal Page['/about'].file,         site['about/index.scss']
  end
end
