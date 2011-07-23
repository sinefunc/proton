title: Helpers
--
Hyde comes with helpers that you can use in your projects. See 
[Hyde::Helpers](../api/Hyde/Helpers.html) for more information.

To add your own helpers, make an extension that makes new methods in the 
module [Hyde::Helpers](../api/Hyde/Helpers.html). Any functions here will be 
available to your files.

## Example

In this example, we'll create a simple helper function.

    [_extensions/hyde-blog/hyde-blog.rb (rb)]
    class Hyde
      module Helpers
        def form_tag(meth, action, &b)
          [ "<form method='#{meth}' action='#{action}'>",
            b.call,
            "</form>"
          ].join("\n")
        end
      end
    end

In your project's site files, you can then now use this helper.

    [my_page.haml (haml)]
    %h1 My form
    != form_tag 'post', '/note/new' do
      %p
        %label Your name:
        %input{ :type => 'text', :name => 'name' }
      %p
        %label Your email:
        %input{ :type => 'text', :name => 'email' }

