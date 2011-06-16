require File.expand_path('../../helper', __FILE__)

class HydeTest < TestCase
  def assert_fixture_works(path, options={})
    build_fixture(path, options) { |control, var|
      assert File.exists?(var), "#{var} doesn't exist"
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


  def build_fixture(path, options={}, &blk)
    # Build
    project = build path

    options[:control_path] ||= '_control'
    options[:public_path]  ||= '_public'

    control_path = project.root(options[:control_path])
    public_path  = project.root(options[:public_path])

    from = Dir["#{control_path}/**/*"].map { |dir| dir.gsub(control_path, '') }.sort
    to   = Dir["#{public_path}/**/*"].map  { |dir| dir.gsub(public_path, '') }.sort

    assert_equal from, to, "The build happened to make less files"

    Dir["#{control_path}/**/*"].each do |control|
      next  unless File.file?(control)
      var = control.sub(control_path, public_path)
      yield control, var
    end   if block_given?
  end

  def read(file)
    File.open(file) { |f| f.read }
  end

  teardown do
    # Remove the generated
    ( Dir[fixture('*', 'public')] +
      Dir[fixture('*', '_public')]
    ).each { |dir| FileUtils.rm_rf dir }
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

  test "fixture sort" do
    assert_fixture_works fixture('sort')
  end

  test "fixture ignores" do
    assert_fixture_works fixture('ignores')
  end

  test "fixture metadata" do
    assert_fixture_works fixture('metadata')
  end

  test "fixture nested_layout" do
    assert_fixture_works fixture('nested_layout')
  end
  
  test "fixture build_options" do
    assert_fixture_works fixture('build_options')
  end

  test "fixture empty_config" do
    assert_fixture_works fixture('empty_config'),
      :control_path => '_control',
      :public_path  => '_output'
  end

  test "fixture high_version" do
    assert_fixture_fails(fixture('high_version')) { |e|
      assert e.message.include?('>= 9000')
    }
  end

  test "fixture fail_type" do
    assert_fixture_fails(fixture('fail_type')) { |e|
      assert e.message.include?('nonexistent')
    }
  end
end
