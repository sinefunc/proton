module Hyde::Helpers
  def page_children(page)
    children = page.children
    of_type  = lambda { |str| children.select { |p| p.html? && p.meta.page_type == str } }

    ch = project.config.subtypes.inject(Hash.new) { |hash, what|
      hash[Inflector[what].pluralize.to_sym] = of_type[what.to_s]
      hash
    }

    ch[:pages] = of_type[nil]

    ch
  end

  def page_types
    project.config.subtypes.map { |s| Inflector[s].pluralize.to_sym } + [:pages]
  end
end

# Inflector['hello'].pluralize
class Inflector < String
  def self.[](str)
    new str.to_s
  end

  def pluralize
    if self[-1] == 's'
      "#{self}es"
    else
      "#{self}s"
    end
  end

  def sentencize
    self.gsub('_', ' ').capitalize
  end
end
