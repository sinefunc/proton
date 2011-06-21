class Proton
class Partial < Layout
protected
  def self.root_path(project, *a)
    project.path(:partials, *a)
  end

  def default_layout
    nil
  end
end
end
