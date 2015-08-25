require 'style_stats/css/selector'
require 'style_stats/css/declaration'
require 'style_stats/css/aggregate_declaration'

class StyleStats
  class Css
    attr_accessor :path, :paths, :rules, :media_types, :selectors, :stylesheets, :elements

    def initialize(path = nil)
      self.path = path
      self.paths = [path]
      self.rules = []
      self.media_types = []
      self.selectors = []
      self.stylesheets = []
      self.elements = []

      self.paths.compact!
      parse if path
    end

    def add_css_parser(parser)
      parser.each_rule_set do |rule, media_types|
        self.rules.push(rule)
        self.media_types.concat(media_types)
        rule.each_selector do |selector, declarations, specificity|
          declarations = declarations.split(/;(?!base64)/).map do |declaration|
            property, value = declaration.split(':', 2).map(&:strip)
            Declaration.new(property, value)
          end
          self.selectors.push(Selector.new(selector, declarations))
        end
      end

      self.media_types.uniq!
      self.media_types.delete(:all)
      self.selectors.sort! { |a, b| b.identifier_count <=> a.identifier_count }
      clear_aggregate
    end

    def merge(css)
      dup.merge!(css)
    end

    def merge!(css)
      clear_aggregate
      self.paths << css.path if css.path
      self.rules += css.rules
      self.media_types += css.media_types
      self.selectors += css.selectors
      self.stylesheets += css.stylesheets
      self.elements += css.elements
      self
    end

    def data_uri_size
      declarations.inject(0) { |sum, declaration| sum += declaration.value.match(/data\:image\/[A-Za-z0-9;,\+\=\/]+/).to_s.size }
    end

    def size
      (self.stylesheets.join + self.elements.join).size
    end

    def gzipped_size
      Zlib::Deflate.deflate(self.stylesheets.join + self.elements.join).size
    end

    def sort_selector_by_declarations_count
      self.selectors.sort { |a, b| b.declarations.count <=> a.declarations.count }
    end

    def selectors_count(type = nil)
      case type
      when :id
        selectors.count { |selector| selector.name.match(/#/) }
      when :universal
        selectors.count { |selector| selector.name.match(/\*/) }
      when :unqualified
        selectors.count { |selector| selector.name.match(/\[.+\]$/) }
      when :js
        selectors.count { |selector| selector.name.match(/[#\\.]js\\-/) }
      else
        seletors.count
      end
    end

    def declarations_count(type = nil)
      case type
      when :important
        declarations.count { |declaration| declaration.value.match(/!important/) }
      when :float
        declarations.count { |declaration| declaration.property.match(/float/) }
      else
        declarations.count
      end
    end

    def [](property)
      aggregate_declaration[property]
    end

    def clear_aggregate
      @aggregate_declaration = nil
    end

    def aggregate_declaration
      @aggregate_declaration ||= aggregate_declarations
    end

    def aggregate_declarations
      aggregate_declaration = AggregateDeclaration.new
      declarations.each { |declaration| aggregate_declaration.add(declaration.property, declaration.value) }
      aggregate_declaration
    end

    def declarations
      self.selectors.map(&:declarations).flatten
    end

    private
    def parse
      path_parser = StyleStats::PathParser.new(self.path)

      self.stylesheets = path_parser.stylesheets
      self.elements = path_parser.style_elements

      parsers = self.stylesheets.map do |stylesheet|
        parser = CssParser::Parser.new
        parser.add_block!(stylesheet)
        parser
      end

      if self.elements && self.elements.empty?.!
        parser = CssParser::Parser.new
        parser.add_block!(self.elements.to_s)
        parsers << parser
      end

      parsers.each { |parser| self.add_css_parser(parser) }
    end
  end
end
