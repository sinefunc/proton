class Hyde
class CLI
module Helpers
  def show_help_for(name)
    task = task(name)
    pass "No such command. Try: #{executable} help"  unless task

    help = task.help
    if help
      help.each { |line| err line }
      err
    else
      err "Usage: #{executable} #{task.usage || name}"
      err "#{task.description}."  if task.description
    end
  end

  def tasks_for(category)
    tasks.select { |name, t| t.category == category }
  end

  def other_tasks
    tasks.select { |name, t| t.category.nil? }
  end

  def say_info(str)
    say_status '*', str, 30
  end

  def say_error(str)
    say_status 'error', str, 31
  end

  def say_status(what, cmd, color=32)
    c1 = "\033[0;#{color}m"
    c0 = "\033[0;m"
    puts "#{c1}%10s#{c0}  %s" % [ what, cmd ]
  end

  def show_needed_gem(name)
    err
    say_error "You will need additional gems for this project."
    say_info "To install: gem install #{name}"
  end

  def no_project
    "Error: no Hyde config file found.\n" +
    "(Looked for #{Hyde::CONFIG_FILES.join(', ')})\n\n" +
    "You start by creating a config file for this project:\n" +
    "  $ #{executable} create .\n\n" +
    "You may also create an empty project in a new directory:\n" +
    "  $ #{executable} create NAME\n"
  end

  def project?
    !! @hydefile
  end

  # Gets the gem name from a LoadError exception.
  def gem_name(e)
    name = e.message.split(' ').last
    name = 'RedCloth'  if name == 'redcloth'
    name = 'haml'  if name == 'sass/plugin'
    name
  end

  def project
    @project ||= begin
      pass no_project unless project?
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
