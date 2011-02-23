class Hyde
class Set < Array
  # Filters a set by given metadata criteria.
  #
  # @example
  #   Page['/'].children.find(layout: 'default')
  #
  def find(by={})
    self.class.new(select do |page|
      by.inject(true) { |b, (field, value)| b &&= (page.meta.send(field) == value) }
    end)
  end

  # Filters a set by removing items matching the given metadata criteria.
  # This is the opposite of #find.
  #
  def except(by={})
    self.class.new(reject do |page|
      by.inject(true) { |b, (field, value)| b &&= (page.meta.send(field) == value) }
    end)
  end
end
end
