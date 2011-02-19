Metadata
========

You may include metadata for pages by placing a YAML document at the beginning
of your page files. Be sure to separate your actual page from the metadata
using two hyphens (`--`)!

    # mypage.haml
    title: This is my page
    author: Jason White
    --
    %div
      -# You may access metadata in using `page.meta.<key>`.
      %h1= page.meta.title
      %cite
        by
        = page.meta.author

Special metadata keys
---------------------

Hyde has a few reserved keys.

### title

You may define a title for a page. You may then access this using `page.title`.

    # mypage-two.haml
    title: This is my page
    --
    %h1= page.title

This shows:

    <h1>This is my page</h1>

If you do not define a title for a page, Hyde automatically uses the page's
filename instead.

    # mypage-three.haml
    %h1= page.title

Output:

    <h1>mypage-three</h1>

### position

You may manually define the order of your pages using the 'position' key.

    # about.haml
    title: About us
    position: 1
    --

    # services.haml
    title: Services
    position: 2
    --

    # contact.haml
    title: Contact us
    position: 9
    --

This will affect the sort order of menus and such. Specifically, it the
outputs of functions such as `page.children`, `page.siblings`, `page.next`,
and so on.

The pages will then be ordered like so:

  - About us
  - Services
  - Contact us

If positions have not been defined, they will be sorted alphabetically by
filename, i.e.:

  - About us
  - Contact us
  - Services

### layout

By default, a page will use the `default` layout. To change this, simply
define a layout key in your metadata:

    # products/camera_cx-300.haml
    title: CX-300 Camera
    layout: product

This will search for `layouts/product.*` (whichever extension it finds) in
your project, and use that as the layout. (This is assuming, of course, that
you haven't changed the default `layouts/` path in your Hyde config file.)
