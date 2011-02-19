class Hyde
class CLI < Shake
  autoload :Helpers, "#{PREFIX}/hyde/cli/helpers"

  extend  Helpers
  include Defaults

  task(:build) do
    project = Hyde::Project.new
    pass no_project  unless project.config_file?

    pre = project.config.output_path

    project.pages.each { |page|
      handler = ''
      handler = "(#{page.tilt_engine_name})"  if page.tilt?
      puts ("\033[0;33m*\033[0;32m #{pre}\033[0;m%-50s%s" % [ page.path, handler ]).strip
      page.write
    }
  end

  task.description = "Builds the current project"

  task(:start) do
    port = (params.extract('-p') || 4833).to_i
    host = (params.extract('-o') || '0.0.0.0')

    require 'hyde/server'
    project = Hyde::Project.new
    pass no_project  unless project.config_file?

    Hyde::Server.run! :Host => host, :Port => port
  end

  task.description = "Starts the server"

  task(:version) do
    puts "Hyde #{Hyde::VERSION}"
  end

  task.description = "Shows the current version"

  def self.run!
    return invoke(:version)  if ARGV == ['-v']
    return invoke(:version)  if ARGV == ['--version']
    super
  end
end
end
