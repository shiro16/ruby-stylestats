class StyleStats::Css
  class Selector
    attr_accessor :name, :declarations

    def initialize(name, declarations = [])
      self.name = name
      self.declarations = declarations
    end

    def identifier_count
      self.name.split(/\>|\+|\~|\:|[\w\]]\.|[\w\]]\#|\[/).count
    end
  end
end
