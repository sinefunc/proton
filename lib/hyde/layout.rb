class Hyde
class Layout < Page
protected
  def self.root_path(project, *a)
    project.path(:layouts, *a)
  end
end
end
