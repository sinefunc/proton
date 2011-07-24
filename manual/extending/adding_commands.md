title: Adding commands
--
Proton uses the [Shake](http://github.com/rstacruz/shake) gem. Add tasks to 
Proton::CLI as you normally would in Shake.

    [extensions/clean/clean.rb (rb)]
    class Proton::CLI
      task :clean do
        wrong_usage  if params.any?

        puts "Cleaning..."
        # Do stuff here
        puts "All clean!"
      end
    end

This may now be used in the command line.

    $ proton clean all
    Invalid usage.
    Type `proton help clean` for more information.

    $ proton clean
    Cleaning...
    All done!

    $ proton --help
    Usage: proton <command> arguments

    Commands:
       ....
       clean            Cleans up your project's dirt
