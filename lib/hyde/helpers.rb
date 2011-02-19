class Hyde
module Helpers
  def partial(path, locals={})
    partial = Partial[path.to_s]  or return ''
    scope = OpenStruct.new :page => self
    partial.to_html scope
  end
end
end
