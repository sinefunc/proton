v0.1.10
-------

 - New Hyde sites will now have a gems manifest. This means you can
   push your Hyde sites to Heroku instantly.
 - Add cuba to dependencies.
 - TODO: check if there are version checking things needed to be done

v0.1.9
------

 - Hotfix: tilt_build_options should work even if there was no tilt_options specified.

v0.1.8
------

 - Fix: 404 pages in 'hyde start' no longer throws an exception log to the viewer.
 - Implemented the `content_for` and `yield_content` helpers.
 - Fix partial locals not working.
 - Allow having the same layouts/partials path as the site.
 - Implement `Hyde.project` which returns the latest project. (deprecates $project)
 - Support tilt_build_options in the config.

v0.1.7
------

 - Show friendlier error messages.
 - Show steps on how to install missing gems when any are encountered.
 - Change 'hyde build' display format to look better.

v0.1.6
------

 - Fix an edge case where files containing '---' somewhere is treated wrong.
 - Ruby 1.8 compatibility.

v0.1.4
------

 - Fix: `hyde start` was giving errors.

v0.1.3
------

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

v0.1.2
------

 - Allow `hyde create .` to add a hyde.conf in the current folder.
 - Revamp the help screen.
 - Fix: change the default load path for Sass/SCSS to 'css'.
 - Add Page#depth.
 - Fix Page#breadcrumbs.
 - Fix Page#parent.
 - Add the `rel` helper.
 - Generated Hyde projects are now Rack-compatible.

v0.1.1
------

 - Default project is now simpler. The site_path is `.`.
 - Implement `Project#build`.
 - If YAML parsing of page metadata fails, treat it as content.
 - All options in `hyde.conf` are now optional (even `hyde_requirement`).
 - Page metadata can now only be a hash.
 - Fix `hyde start`.
 - Minimum Ruby version is now at 1.8.6.

v0.1.0
------

**Complete rewrite.** Many thing have been deprecated.

 - Now uses Tilt (for templates), Shake (for CLI) and Cuba (for the server).
 - Now supports everything Tilt supports: CoffeeScript, Liquid, etc.
 - Allow `tilt_options` in hyde.conf.
 - Old extensions will be broken (but who made any yet, anyway?)
 - Update the `hyde create` template's gitignore file to account for _public.

v0.0.8
------

 - Add support for subclassing. (just add a 'type' meta)
 - Implement Project#all.
 - Implement Page#all and Page#all(type).
 - Fix binary files losing extensions on 'hyde build'.
 - Allow "layout: false" to ensure that a page doesn't have a layout.
 - Fix bug where "index.html.haml" and "index.rss.haml" clash.
 - Implement Page#content.

v0.0.7
------

 - Add support for Sass and SCSS.
 - Add support for ignored files.

v0.0.6
------

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

v0.0.5 - 2010-05-30
-------------------

 - Implemented `content_for` and `yield_content` helpers
 - Added `partials_path` config variable
 - Changed helper method `partial`s syntax (from `partial X, :locals => { ... }` to `partial X, ...`)
 - Line numbers for errors are shown now
 - Added rudimentary 404 page
 - Added `hyde_requirement` config variable -- Hyde will now not proceed if the project needs a later version of Hyde
 - Extensions are now auto-guessed (for example, 'foo.less' will be accessible as 'foo.css')

v0.0.4 - 2010-05-25
-------------------

 - First public release
