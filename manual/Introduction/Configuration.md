Configuration
=============

Configuration is done through the file `hyde.conf` placed in 
your project's root folder. A sample config file is generated
when doing `hyde create`.

It is a YAML file, so the basic format of the file is:

     option: value
     # Lines starting with # are comments that are ignored.

Options
-------

hyde_requirement
: The minimum version of Hyde needed by the project. Example:

    hyde_requirement: 0.0.5

site_path
: The folder where the site's main files are kept. (you can set this to '.')
  This is the path where your main files are. Example:

    # myproject/hyde.conf
    site_path: site

    # This will instruct hyde to look at myproject/site/ for the
    # files of the project.

layouts_path
: The folder where the layout templates (and partials) are kept. See the
  {file:Layouts Layouts} section for information on Hyde layouts.

partials_path
: The folder for partials. See the {file:Partials Partials} section for
  an overview of what partials are.

extensions_path
: The folder where the optional extensions are kept. See the
  {file:ExtendingHyde Extending Hyde} section for more info on extensions.

output_path
: The folder where the HTML files are to be built when typing `hyde build`.

More options
------------

These options are not in the default `hyde.conf`, but you may simply
add them in.

port
: The port number. Defaults to 4833 unless set. Example:

    port: 4999

gems
: This is a list of Ruby gems to be autoloaded into Hyde. Some extensions
  are available as gems and may simply be added here to be used. Example:

    gems:
      - hyde-rst
      - hyde-zip

Hidden hyde config file
-----------------------

Don't like seeing `hyde.conf` littering up your project folder? Rename
it to `.hyderc`.

