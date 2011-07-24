title: Creating extensions
--
In your project's extensions folder (`extensions` by default), create a file called
`<name>/<name>.rb`, where `<name>` is the name of your extension. This file will automatically loaded.

Example:

    [extensions/blog/blog.rb (rb)]
    class Proton
      # Set up autoload hooks for the other classes
      prefix = File.dirname(__FILE__)
      autoload :Blog,   "#{prefix}/lib/blog.rb"
    end

