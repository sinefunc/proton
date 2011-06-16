require File.expand_path('../../helper', __FILE__)

class ExtensionsTest < TestCase
  setup do
    $extension_loaded = nil
    @project = build fixture('extensions')
  end

  teardown do
    unbuild @project
  end

  test "extensions" do
    assert $extension_loaded == "aoeu"
    assert $hi == 1
  end
end
