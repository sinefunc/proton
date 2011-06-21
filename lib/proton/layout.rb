class Proton
class Layout < Page
  attr_accessor :page

  def self.[](id, page)
    object = super(id, page.project)
    object.page = page  if object
    object
  end

protected
  def self.root_path(project, *a)
    project.path(:layouts, *a)
  end

  def default_layout
    nil
  end
end
end
