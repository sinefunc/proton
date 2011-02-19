class Hyde
class Layout < Page
protected
  def self.root_path(project, *a)
    project.path(:layouts, *a)
  end

  def default_layout
    nil
  end
end
end
