class AggregateDeclaration
  attr_accessor :declarations

  def initialize()
    self.declarations = {}
  end

  def add(property, value)
    if self.declarations.has_key?(property)
      self.declarations[property][:values] << value
      self.declarations[property][:values].uniq!
      self.declarations[property][:count] += 1
    else
      self.declarations[property] = {values: [value], count: 1}
    end
  end

  def [](property)
    self.declarations[property] || []
  end
end
