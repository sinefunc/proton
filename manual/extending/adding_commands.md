title: Adding commands
--
Hyde uses [Shake](http://github.com/rstacruz/shake). Add tasks to Hyde::CLI
as you normally would in Shake.

    [extensions/hyde-clean/hyde-clean.rb (rb)]
    class Hyde::CLI
      task :clean do
        wrong_usage  if params.any?

        puts "Cleaning..."
        # Do stuff here
        puts "All clean!"
      end
    end

This may now be used in the command line.

    $ hyde clean all
    Invalid usage.
    Type `hyde help clean` for more information.

    $ hyde clean
    Cleaning...
    All done!

    $ hyde --help
    Usage: hyde <command> arguments

    Commands:
       ....
       clean            Cleans up your project's dirt
