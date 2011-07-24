title: Configuration
--

Configuration is done through the file `Protonfile` placed in your project's 
root folder. A sample config file is generated
when doing `proton create`.

It is a YAML file, so the basic format of the file is:

    [Protonfile (yaml)]
    option: value
    # Lines starting with # are comments that are ignored.

### requirement

The minimum version of Proton needed by the project. Example:

    [Protonfile (yaml)]
    requirement: 0.0.5

### site_path
The folder where the site's main files are kept. (you can set this to '.')
  This is the path where your main files are. Example:

    [myproject/Protonfile (yaml)]
    # This will instruct Proton to look at myproject/site/ for the
    # files of the project.

    site_path: site/


### layouts_path
The folder where the layout templates (and partials) are kept. See the
  [Layouts](layouts.html) section for information on Proton layouts.

### partials_path
The folder for partials. See the [Partials](partials.html) section for
  an overview of what partials are.

### extensions_path
The folder where the optional extensions are kept. See the
  [Extending Proton](extending.html) section for more info on extensions.

### output_path
The folder where the HTML files are to be built when typing `proton build`.

More options
------------

These options are not in the default `Protonfile`, but you may simply
add them in.

### port
The port number. Defaults to 4833 unless set. Example:

    [Protonfile (yaml)]
    port: 4999

### gems
This is a list of Ruby gems to be autoloaded into Proton. Some extensions
are available as gems and may simply be added here to be used. Example:

    [Protonfile (yaml)]
    gems:
      - proton-rst
      - proton-zip

Hidden Proton config file
-------------------------

Don't like seeing `Protonfile` littering up your project folder? Rename
it to `.protonrc`.

