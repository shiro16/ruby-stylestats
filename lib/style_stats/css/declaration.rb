class StyleStats::Css
  class Declaration
    attr_accessor :property, :value, :important

    def initialize(property, value)
      self.important = !!value.match(/!important/)
      self.property = property
      self.value = value.gsub("!important", '').strip.force_encoding("utf-8")
    end
  end
end
