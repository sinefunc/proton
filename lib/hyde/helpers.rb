class Hyde
module Helpers
  def partial(path, locals={})
    partial = Partial[path.to_s, page]  or return ''
    partial.to_html locals.merge(:page => self)
  end

  def rel(path)
    depth = page.path.count('/')
    dotdot = depth > 1 ? ('../' * (depth-1)) : './'
    (dotdot[0...-1] + path)
  end

  def content_for(key, &blk)
    content_blocks[key.to_sym] = blk
  end

  def content_blocks
    $content_blocks ||= Hash.new
    $content_blocks[page.path] ||= Hash.new
  end

  def has_content?(key)
    content_blocks.member? key.to_sym
  end

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
