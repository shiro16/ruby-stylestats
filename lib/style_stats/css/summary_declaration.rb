class SummaryDeclaration
  attr_accessor :values, :count

  def initialize(value=nil)
    self.values = value.nil? ? [] : [value]
    self.count = self.values.count
  end

  def add(value)
    self.values << value
    self.count += 1
    self.values.uniq!
  end
end
