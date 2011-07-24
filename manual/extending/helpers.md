title: Helpers
--
Proton comes with helpers that you can use in your projects. See 
[Proton::Helpers](../api/Proton/Helpers.html) for more information.

To add your own helpers:

 * Create a Ruby file in the _extensions folder.
 * Add new methods to the module 
 [Proton::Helpers](../api/proton/helpers.html).
 
Any methods here will be available to your pages and templates.

## Example

In this example, we'll create a simple helper function.

    [_extensions/helpers.rb (rb)]
    class Proton
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

