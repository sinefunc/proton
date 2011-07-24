title: Template languages
--

Proton comes with support for some common template languages. This means you 
can write your site in a language like Markdown or HAML, and have Proton take 
care of translating them accordingly.

If a file ends in one of Proton's supported file extensions (like `.haml`), it 
will be stripped out and the file will be rendered using the template engine 
in that extension (in this case, HAML).

Supported languages
-------------------

Proton supports the following languages out-of-the-box:

 - HTML template languages
   - `.haml` (HAML)
   - `.md` (Markdown)
   - `.textile` (Textile)
   - `.erb` (ERB, Embedded Ruby)

 - CSS template languages
   - `.less` (LessCSS)
   - `.sass` (Sass)
   - `.scss` (Sass CSS)

 - JavaScript
   - `.coffee` (CoffeeScript)

This means that the following files will be translated accordingly:

 - `products.haml` becomes `products.html` (rendered through HAML)
 - `control.less` becomes `control.css` (rendered through Less CSS)
 - `site.xml.erb` becomes `site.xml` (rendered through Embedded Ruby)

Example
-------

When creating a new site, have a look at `index.haml`.

...

Headers
-------

...

Layouts
-------

Layouts are supported for HAML, Markdown, Textile and ERB languages.

...

Embedded Ruby features
----------------------

Some languages (like HAML and ERB) has support for embedding Ruby code in the
documents. This will let you do some nifty things in Proton:

 - Partials
 - Helpers
