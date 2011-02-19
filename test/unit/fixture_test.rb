require File.expand_path('../../helper', __FILE__)

class HydeTest < TestCase
  def assert_fixture_works(path)
    build_fixture(path) { |control, var|
      assert File.exists?(var)
      if read(control) != read(var)
        flunk "Failed in #{var}\n" +
          "Control:\n" +
          read(control).gsub(/^/, '|    ') + "\n\n" + 
          "Variable:\n" +
          read(var).gsub(/^/, '|    ')
      end
    }
  end

  def assert_fixture_fails(path, error=Hyde::Error, &blk)
    begin
      build_fixture(path)
    rescue error => e
      yield e
    else
      flunk "Assertion failed"
    end
  end


  def build_fixture(path, &blk)
    # Build
    project = build path

    Dir[project.root('control/**/*')].each do |control|
      next  unless File.file?(control)
      var = control.sub('/control/', '/public/')
      yield control, var
    end   if block_given?
  end

  def read(file)
    File.open(file) { |f| f.read }
  end

  teardown do
    # Remove the generated
    Dir[fixture('*', 'public')].each { |dir| FileUtils.rm_rf dir }
  end

  test "fixture one" do
    assert_fixture_works fixture('one')
  end

  test "fixture subclass" do
    assert_fixture_works fixture('subclass')
  end

  test "fixture extensions" do
    assert_fixture_works fixture('extensions')
  end

  test "fixture parent" do
    assert_fixture_works fixture('parent')
  end

  test "fixture fail_one" do
    assert_fixture_fails(fixture('fail_one')) { |e|
      assert e.message.include?('nonexistent')
    }
  end
end
