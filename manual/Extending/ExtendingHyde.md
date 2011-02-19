Extending Hyde
==============

Creating extensions
-------------------

In your Hyde project's extensions folder (`extensions` by default), create a file called
`<name>/<name>.rb`, where `<name>` is the name of your extension. This file will automatically loaded.

Example:

    # extensions/hyde-blog/hyde-blog.rb
    class Hyde
      # Set up autoload hooks for the other classes
      prefix = File.dirname(__FILE__)
      autoload :Blog,   "#{prefix}/lib/blog.rb"
    end

Adding helpers
--------------

Place any helpers in `Hyde::Helpers`. Any functions here will be available to your files.

Example:

In this example, we'll create a simple helper function.

    # extensions/hyde-blog/hyde-blog.rb
    class Hyde
      module Helpers
        def form_tag(meth, action, &b)
          [ "<form method='#{meth}' action='#{action}'>",
            b.call,
            "</form>"
          ].join("\n")
        end
      end
    end

In your project's site files, you can then now use this helper.

    # site/my_page.html.haml
    %h1 My form
    != form_tag 'post', '/note/new' do
      %p
        %label Your name:
        %input{ :type => 'text', :name => 'name' }
      %p
        %label Your email:
        %input{ :type => 'text', :name => 'email' }

Adding commands
---------------

Hyde uses [Shake](http://github.com/rstacruz/shake). Add tasks to Hyde::CLI
as you normally would in Shake.

    # extensions/hyde-clean/hyde-clean.rb
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
