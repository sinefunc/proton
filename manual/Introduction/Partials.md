Partials
========

A partial is a snippet of code that you can reuse in any page of your site.
This is particularly useful for repetitive sections, and for sections that may
make your files too large to manage.

Creating partials
-----------------

Put your partial file anywhere in the `layouts` folder, e.g.:

    <!-- layouts/shared/sidebar.erb -->
    <div id='#sidebar'>
      <h2><span>Sidebar</span><h2>
      <div class='description'>
        <p>This is a sidebar partial defined in a separate file.</p>
      </div>
    </div>

In your site's files, you can invoke a partial through:

    <!-- site/index.html.erb -->
    <h1>Partial:</h1>
    <%= partial 'shared/sidebar' %>
    <span>End of partial.</span>
    <span>This is now text from index.html.</span>

This will output:
    
    <!-- public/index.html -->
    <h1>Partial:</h1>
    <div id='#sidebar'>
      <h2><span>Sidebar</span><h2>
      <div class='description'>
        <p>This is a sidebar partial defined in a separate file.</p>
      </div>
    </div>
    <span>End of partial.</span>
    <span>This is now text from index.html.</span>

Partials with local variables
-----------------------------

You can define a partial with some local variables that will be passed
to it by the caller.

    <!-- layouts/shared/product.erb -->
    <div class='product'>
      <div class='title'>
        <h2><%= name %></h2>
      </div>
      <div class='desc'>
        <p><%= description %></p>
      </div>
    </div>

In your files, call a partial by:
      
    <!-- site/index.html.erb -->
    <%= partial 'shared/product', { :name => '5MP Camera CX-300', :description => 'This is a camera with an adjustable focal length and Bluetooth support.' } %>

Partials in HAML files
----------------------

HAML support in Hyde has the `escape_html` option on by default. You
will need to use `!= partial` instead of `= partial`.

    -# Don't forget the exclamation point!
    != partial 'shared/product'

If you omit the `!`, the partial will be rendered with it's HTML code
escaped.
