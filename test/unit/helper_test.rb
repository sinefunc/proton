require File.expand_path('../../helper', __FILE__)

class HelperTest < TestCase
  include Proton::Helpers

  test "rel" do
    assert_equal 'index.html', rel('index.html', '/about/index.html')
    assert_equal '../index.html', rel('/index.html', '/about/index.html')
    assert_equal '../foo/index.html', rel('/foo/index.html', '/about/index.html')
    assert_equal '../about/us.html', rel('/about/us.html', '/about/index.html')
  end
end
