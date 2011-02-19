class Hyde
module Helpers
  def partial(path, locals={})
    partial = Partial[path.to_s]  or return ''
    partial.to_html :page => self
  end
end
end
