Getting started
===============

Starting your first project
---------------------------

Create your first project with:

    hyde create <name>

Where `<name>` is the name of your project. This will create a folder with that
name, along with some sample files to get you started.

Starting
--------

Begin working on your project by starting the Hyde webserver. This is optional,
but is recommended as it's a nice way to see your changes in real time.

    hyde start

After typing this, you will see the server has started. Point your web browser to
`http://localhost:4833` to see your site. You should now see your project's
default "welcome" page.


Editing your site
-----------------

Your project has a subfolder called `site` -- this is where all the site's files are
stored. In general, dropping any file in this folder will make it accessible with the
same filename.

Try this: create a file called `products.html` and fill it up like you would an
HTML page. After that, point your browser to `http://localhost:4833/products.html`,
which should now show the page you were working on.

You may also put your files in subfolders. If you were to create the file
`site/assets/my_style.css`, it should be accessible through
`http://localhost:4833/assets/my_style.css`.

Dynamic files
-------------

Hyde supports many templating languages like HAML, Less, and ERB (more on this later).
If your file ends in one of these supported extensions (e.g., `index.haml`), it
is assumed to be a dynamic file and will be rendered by it's corresponding templating
engine (in this case, HAML).

Building HTML files
-------------------

The `hyde start` webserver is good for local development, but when it's time to
deploy your site, you will need to build your files. This process outputs raw
HTML files for your entire site (for the dynamic files), with Hyde translating
any files that need translation (e.g., HAML and ERB files).

Build your files by typing this in the command prompt:

    hyde build

This will create a folder called `public/` where the built files are stored.
You can now deploy this folder to your webserver.

