module Hyde::Helpers
  def page_children(page)
    children = page.children
    of_type  = lambda { |str| children.select { |p| p.html? && p.meta.layout == str } }

    children = {
      :methods => of_type['method'],
      :class_methods => of_type['class_method'],
      :classes => of_type['class'],
      :attributes => of_type['attribute'],
      :modules => of_type['module'],
      :constants => of_type['constant'],
      :pages => of_type[nil] + of_type['default'],
    }
  end

  def page_types
    [:modules, :classes, :attributes, :class_methods, :methods, :pages]
  end
end

# Inflector['hello'].pluralize
module Inflector < String
  def self.[](str)
    new str
  end

  def pluralize
    str = if self[-1] == 's'
      "#{str}es"
    else
      "#{str}s"
    end

    self.new str
  end

  def sentencize
    self.gsub('_', ' ').capitalize
  end
end
