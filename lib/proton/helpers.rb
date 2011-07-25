# Module: Proton::Helpers
# Helpers you can use in your pages.
#
# ## Creating your own helpers
#    To create for own helpers, make an extension. See [Extending Proton: 
#    Helpers][1] for more info.
#
# [1]: /extending/helpers.html

class Proton
module Helpers

  # Helper: partial (Helpers)
  # Renders a partial.
  #
  # ## Usage
  #     <%= partial path, locals %>
  #
  # ## Description
  #    See [Introduction: Partials](/introduction/partials.html) for more 
  #    info.
  #
  # ## Example
  #
  # If your `_layouts/_banner.erb` looks like this:
  #
  #     <div class='banner'>
  #       Welcome to <%= start.title %>
  #     </div>
  #
  # ...Then this will embed the partial `_layouts/_nav.erb`. The partial
  # will be rendered with `start` being set to the current page.
  #
  #     <%= partial '_banner', :start => page %>
  #
  def partial(path, locals={})
    partial = Partial[path.to_s, page]  or return ''
    partial.to_html locals.merge(:page => self)
  end

  # Helper: rel (Helpers)
  # Turns a path into a relative path.
  #
  # ##  Usage
  #     <%= rel(path) %>
  #
  # ## Description
  #    `rel` takes a given absolute path that begins with a `/` (for instance, 
  #    `/x/y/z.html`) and returns a relative path (maybe `../y/z.html`). This is
  #    useful if your site will not be be hosted on it's own domain.
  #
  # ##  Example
  #     <% page.children.each do |child| %>
  #       <a href="<%= rel(child.path) %>">
  #         <%= child.title %>
  #       </a>
  #     <% end %>
  #
  #  This may output:
  #
  #     <a href="../../foo.html">
  #       Foobar
  #     </a>
  #
  # ...where the `../../` depends on the current page's path.
  #
  def rel(path, from=page.path)
    if path[0] == '/'
      depth = from.count('/')
      dotdot = depth > 1 ? ('../' * (depth-1)) : './'
      str = (dotdot[0...-1] + path).squeeze('/')
      str = str[2..-1]  if str[0..-1] == './'
      str
    else
      path
    end
  end

  # Helper: content_for (Helpers)
  # Content for.
  #
  # ## See also
  #
  #  * {Helpers:has_content?}
  #  * {Helpers:content_for}
  #  * {Helpers:yield_content}
  #
  def content_for(key, &blk)
    content_blocks[key.to_sym] = blk
  end

  def content_blocks
    $content_blocks ||= Hash.new
    $content_blocks[page.path] ||= Hash.new
  end

  # Helper: has_content? (Helpers)
  # Checks if there's something defined for a given content block.
  #
  # ## Example
  #    See {Helpers:content_for} for an example.
  #
  # ## See also
  #  * {Helpers:has_content?}
  #  * {Helpers:content_for}
  #  * {Helpers:yield_content}
  #
  def has_content?(key)
    content_blocks.member? key.to_sym
  end

  # Helper: yield_content (Helpers)
  # Yield
  #
  # ## Example
  #    See {Helpers:content_for} for an example.
  #
  # ## See also
  #  * {Helpers:has_content?}
  #  * {Helpers:content_for}
  #  * {Helpers:yield_content}
  #
  def yield_content(key, *args)
    content = content_blocks[key.to_sym]
    if respond_to?(:block_is_haml?) && block_is_haml?(content)
      capture_haml(*args, &content)
    elsif content
      content.call(*args)
    end
  end
end
end
