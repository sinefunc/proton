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
    "No project file here."
  end

  def project
    @project ||= begin
      pass no_project unless @hydefile
      Dir.chdir File.dirname(@hydefile)

      project = Hyde::Project.new
      pass no_project  unless project.config_file?

      project
    end
  end
end
end
end
