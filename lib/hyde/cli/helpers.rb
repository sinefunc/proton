class Hyde
class CLI
  module Helpers
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
