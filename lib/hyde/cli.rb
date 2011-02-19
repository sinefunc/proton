class Hyde
class CLI < Shake
  autoload :Helpers, "#{PREFIX}/hyde/cli/helpers"

  extend  Helpers
  include Defaults

  task(:create) do
    wrong_usage  unless params.size == 1

    template = File.expand_path('../../../data/new_site', __FILE__)
    target   = params.first

    pass "Error: target directory already exists."  if File.directory?(target)

    puts "Creating files in #{target}:"
    puts

    FileUtils.cp_r template, target
    Dir[File.join(target, '**', '*')].sort.each do |f|
      say_status :create, f  if File.file?(f)
    end

    puts ""
    puts "Done! You've created a new project in #{target}."
    puts "Get started now:"
    puts ""
    puts "  $ cd #{target}"
    puts "  $ #{executable} start"
    puts ""
    puts "Or build the HTML files:"
    puts ""
    puts "  $ #{executable} build"
    puts ""
  end

  task.description = "Starts a new Hyde project"
  task.usage = "create NAME"

  task(:build) do
    pre = project.config.output_path

    begin
      project.pages.each { |page|
        handler = ''
        handler = "(#{page.tilt_engine_name})"  if page.tilt?
        puts ("\033[0;33m*\033[0;32m #{pre}\033[0;m%-50s%s" % [ page.path, handler ]).strip
        page.write
      }
    rescue NoGemError => e
      err "Error: #{e.message}"
    ensure
      project.build_cleanup
    end
  end

  task.description = "Builds the current project"

  task(:start) do
    port = (params.extract('-p') || 4833).to_i
    host = (params.extract('-o') || '0.0.0.0')

    require 'hyde/server'

    Hyde::Server.run! :Host => host, :Port => port
  end

  task.description = "Starts the server"

  task(:version) do
    puts "Hyde #{Hyde::VERSION}"
  end

  task.description = "Shows the current version"

  def self.run!(options={})
    @hydefile = options[:file]
    return invoke(:version)  if ARGV == ['-v']
    return invoke(:version)  if ARGV == ['--version']

    begin
      super *[]
    end
  end
end
end
