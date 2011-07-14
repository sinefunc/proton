Proton v0.3.3 - Jul 14, 2011
----------------------------

Small fixes again.

### Added:
  * a confirmation message when running 'proton rack'.

### Changed:
  * the default site to read 'Proton' instead of 'Hyde' in the default title.
  * Update 'proton rack' to generate Gemfile.lock.

Proton v0.3.2 - Jun 22, 2011
----------------------------

Hotfixes.

### Fixed:
  * `Gemfile` and `Gemfile.lock` are now auto ignored when doing *proton build*.
  * Fixed the `rel()` helper.

Proton v0.3.0 - Jun 22, 2011
----------------------------

**The project has been renamed to Proton** (previously called *Hyde*).

A manual is also in progress, currently hosted at 
[sinefunc.com/hyde/manual](http://sinefunc.com/hyde/manual).

### Renamed:
  * * The main class is now called `Proton` instead of `Hyde`. However, *Hyde* 
  still works as an alias.
  * The main executable is now called `proton` (and not `hyde`).
  * The configuration file is now called `Protonfile`. The legacy *hyde.conf* 
  and *.hyderc* still works for backward-compatibility.

### Added:
  * New `proton rack` command to Rackify a given project.

### Changed:
  * Creating a project with `proton create` will now not include any gem 
  manifest or *config.ru* file.

Hyde v0.2.3 - Jun 20, 2011
--------------------------

### Changed:
  * Use a bundler Gemfile for Hyde sites if a Gemfile is found.

### Fixed:
  * **Fixed `hyde create`.**
  * Fixed overriding of Hyde::CLI via commands not working.
  * Fixed the rel() helper.

Hyde v0.2.2 - Jun 16, 2011
--------------------------

### Added:
  * **Built-in Compass support.**
  * **Enable Sass, SCSS, Haml, Textile and Markdown by default.**
  * Extensions from `_extensions/*rb` will now be loaded.

### Changed:
  * The default `hyde.conf` now comments out the default stuff you don't need to set.
  * Update dependencies to Cuba 2.0, and Hashie 1.0.

Hyde v0.1.14 - Jun 04, 2011
---------------------------

### Fixed:
  * Fixed a syntax error in page.rb.
  * Don't impose gem versions explicitly, and don't load Rubygems if used as a 
  library.

### Misc:
  * Added some doc comments to the main classes.

Hyde v0.1.13
------------

 - Try to fix an edge case where the path '/' gives you an arbitrary dotfile.

Hyde v0.1.11
------------

 - Deprecate in-app caching for rack-cache.
 - The Hyde server now sends the Last-Modified HTTP header.
 - New Hyde sites will now use rack-cache (optionally) when used as a Rack site.

Hyde v0.1.10
-------

 - New Hyde sites will now have a gems manifest. This means you can
   push your Hyde sites to Heroku instantly.
 - Add cuba to dependencies.
 - The server now serves the right MIME types.
 - When used as a Rack app, Hyde sends cache headers.

Hyde v0.1.9
-----------

 - Hotfix: tilt_build_options should work even if there was no tilt_options specified.

Hyde v0.1.8
-----------

 - Fix: 404 pages in 'hyde start' no longer throws an exception log to the viewer.
 - Implemented the `content_for` and `yield_content` helpers.
 - Fix partial locals not working.
 - Allow having the same layouts/partials path as the site.
 - Implement `Hyde.project` which returns the latest project. (deprecates $project)
 - Support tilt_build_options in the config.

Hyde v0.1.7
-----------

 - Show friendlier error messages.
 - Show steps on how to install missing gems when any are encountered.
 - Change 'hyde build' display format to look better.

Hyde v0.1.6
-----------

 - Fix an edge case where files containing '---' somewhere is treated wrong.
 - Ruby 1.8 compatibility.

Hyde v0.1.4
-----------

 - Fix: `hyde start` was giving errors.

Hyde v0.1.3
-----------

 - .html files are now being treated as .erb.
 - Implement `page.children.find`.
 - Implement `page.children.except`.
 - Fix #children and sorting giving errors.
 - Fix #siblings.
 - Revise the 'no config file found' error message.
 - Allow `.hyderc` as a filename.
 - Add help for `hyde help start`.
 - Support `hyde start -D` which is a very hackish solution to have
   Hyde start as a daemon.

Hyde v0.1.2
-----------

 - Allow `hyde create .` to add a hyde.conf in the current folder.
 - Revamp the help screen.
 - Fix: change the default load path for Sass/SCSS to 'css'.
 - Add Page#depth.
 - Fix Page#breadcrumbs.
 - Fix Page#parent.
 - Add the `rel` helper.
 - Generated Hyde projects are now Rack-compatible.

Hyde v0.1.1
-----------

 - Default project is now simpler. The site_path is `.`.
 - Implement `Project#build`.
 - If YAML parsing of page metadata fails, treat it as content.
 - All options in `hyde.conf` are now optional (even `hyde_requirement`).
 - Page metadata can now only be a hash.
 - Fix `hyde start`.
 - Minimum Ruby version is now at 1.8.6.

Hyde v0.1.0
-----------

**Complete rewrite.** Many thing have been deprecated.

 - Now uses Tilt (for templates), Shake (for CLI) and Cuba (for the server).
 - Now supports everything Tilt supports: CoffeeScript, Liquid, etc.
 - Allow `tilt_options` in hyde.conf.
 - Old extensions will be broken (but who made any yet, anyway?)
 - Update the `hyde create` template's gitignore file to account for _public.

Hyde v0.0.8
-----------

 - Add support for subclassing. (just add a 'type' meta)
 - Implement Project#all.
 - Implement Page#all and Page#all(type).
 - Fix binary files losing extensions on 'hyde build'.
 - Allow "layout: false" to ensure that a page doesn't have a layout.
 - Fix bug where "index.html.haml" and "index.rss.haml" clash.
 - Implement Page#content.

Hyde v0.0.7
-----------

 - Add support for Sass and SCSS.
 - Add support for ignored files.

Hyde v0.0.6
-----------

 - Added support for blocks for `yield_content` (as default text).
 - `Page#referrer` now is a page (instead of a string of the name).
 - Partials path is now not ignored by default.
 - Add support for page ordering (by the `position` key in metadata).
 - You can now start an IRB session with the `hyde console` command.
 - Implement traversion methods for page: #next, #previous, #siblings,
   and #parent.
 - Implement the 'page' variable to be available in pages.
 - Add Page#title.
 - Add Page#path.
 - Add Page#breadcrumbs.
 - Implement Utils#escape_html.
 - Hyde now always tries 'layouts/default.*' as the default layout, if none's
   specified. (TODO: layout: false)
 - Implement Renderer.layoutable?, which dictates if a renderer is capable of
   having a layout.

Hyde v0.0.5 - 2010-05-30
------------------------

 - Implemented `content_for` and `yield_content` helpers
 - Added `partials_path` config variable
 - Changed helper method `partial`s syntax (from `partial X, :locals => { ... }` to `partial X, ...`)
 - Line numbers for errors are shown now
 - Added rudimentary 404 page
 - Added `hyde_requirement` config variable -- Hyde will now not proceed if the project needs a later version of Hyde
 - Extensions are now auto-guessed (for example, 'foo.less' will be accessible as 'foo.css')

Hyde v0.0.4 - 2010-05-25
------------------------

 - First public release
