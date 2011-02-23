class Hyde
module Helpers
  def partial(path, locals={})
    partial = Partial[path.to_s, page]  or return ''
    partial.to_html :page => self
  end

  def rel(path)
    depth = page.depth
    dotdot = depth > 1 ? ('../' * (page.depth-1)) : './'
    (dotdot[0...-1] + path)
  end
end
end
