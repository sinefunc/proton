v0.1.0
------

 - Complete rewrite. Many thing have been deprecated.
 - Now uses Tilt and Shake.

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
