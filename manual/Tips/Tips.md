Tips
====

Here are some tips and tricks!

Simpler folder structure
------------------------

The default folder structure looks like this:

    project/
      hyde.conf
      layouts/
      partials/
      public/
      extensions/
      site/
        about.html
        contact.html

Here is a cleaner structure often used in simpler projects:

    project/
      about.html
      contact.html

      .hyderc
      _/
        layouts/
        partials/
        public/
        extensions/

You may do this by editing your Hyde config file like so:

    site_path:       .
    layouts_path:    _/layouts
    extensions_path: _/extensions
    partials_path:   _/partials
    output_path:     _/public

Optionally, you can rename `hyde.conf` to `.hyderc` to make it even cleaner.
