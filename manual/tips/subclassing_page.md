title: Subclassing Page
--
You may subclass the [Hyde::Page](../api/Hyde/Page.md) class.

## Subclassing in an extension

Create an extension to subclass it:

    # _extensions/post/post.rb
    class Proton::Page::Post < Proton::Page
      # Put some extra methods here
      def css_class
        title.downcase.gsub(' ', '-')
      end
    end

## Using your subclass

Now in your files, specify the type with `type` metadata:

    # hello.textile
    title: Hello world
    type: post
    layout: default
    --
    Hello, world! This page will be of type Post.

## Subclasses in posts

Now in the layout, the `page` variable will be an instance of 
`Proton::Page::Post`.

    # _layouts/default.haml
    %body
      - if page.is_a? Proton::Page::Post
        %h1{class: page.css_class}
          Post:
          = page.title

## Changing default layouts per subclass

You can redefine `Page::default_layout` to change the default layout for the 
page subclass.

    class Proton::Page::Post < Proton::Page
      def default_layout
        'post'  if html?
      end
    end
