class StyleStats::Css
  class Selector
    attr_accessor :name, :declarations

    def initialize(name, declarations = [])
      self.name = name
      self.declarations = declarations
    end

    def identifier_count
      trimmed_name = self.name.gsub(/\s?([\>\+\~])\s?/) { $1 }
      trimmed_name.gsub(/\s+/, ' ').split(/\s|\>|\+|\~|\:|[\w\]]\.|[\w\]]\#|\[/).count
    end
  end
end
