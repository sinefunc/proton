class Hyde
class CLI
module Helpers
  def say_info(str)
    say_status '*', str, 30
  end

  def say_status(what, cmd, color=32)
    c1 = "\033[0;#{color}m"
    c0 = "\033[0;m"
    puts "#{c1}%10s#{c0}  %s" % [ what, cmd ]
  end

  def no_project
    "Error: This is not a Hyde project.\n" +
    "You may convert it into one by creating a config file:\n" +
    "  $ #{executable} create .\n\n" +
    "You may also create an empty project in a new directory:\n" +
    "  $ #{executable} create NAME\n"
  end

  def project
    @project ||= begin
      pass no_project unless @hydefile
      Dir.chdir File.dirname(@hydefile)

      begin
        project = Hyde::Project.new
        pass no_project  unless project.config_file?
      rescue LegacyError
        err "This is a legacy Hyde project."
        err "To force it, try editing `hyde.conf` and upgrade the version line to `hyde_requirement: 0.1`."
        pass
      rescue VersionError => e
        err e.message
        pass
      end

      project
    end
  end
end
end
end
