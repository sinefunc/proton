# Class: Hyde::Set
# A set of pages.

class Hyde
class Set < Array
  # Method: find (Hyde::Set)
  # Filters a set by given metadata criteria.
  #
  # ##  Example
  #     Page['/'].children.find(layout: 'default')
  #
  def find(by={})
    self.class.new(select do |page|
      by.inject(true) { |b, (field, value)| b &&= (page.meta.send(field) == value) }
    end)
  end

  # Method: except (Hyde::Set)
  # Filters a set by removing items matching the given metadata criteria.
  #
  # This is the opposite of {Hyde::Set::find}.
  #
  # ##  Example
  #     Page['/'].children.find(layout: 'default')
  #
  def except(by={})
    self.class.new(reject do |page|
      by.inject(true) { |b, (field, value)| b &&= (page.meta.send(field) == value) }
    end)
  end
end
end
