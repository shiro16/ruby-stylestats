require 'style_stats/css/selector'
require 'style_stats/css/declaration'
require 'style_stats/css/summary_declaration'
class StyleStats
  class Css
    attr_accessor :path, :size, :rules, :media_types, :selectors, :summary_declarations

    def initialize(path)
      self.path = path
      self.size = 0
      self.rules = []
      self.media_types = []
      self.selectors = []
      self.summary_declarations = {}

      path_parser = StyleStats::PathParser.new(path)

      parsers = path_parser.stylesheets.map do |file|
        self.size += open(file).size

        parser = CssParser::Parser.new
        parser.load_uri!(file)
        parser
      end

      if path_parser.style_element && path_parser.style_element.empty?.!
        self.size += path_parser.style_element.length
        parser = CssParser::Parser.new
        parser.add_block!(path_parser.style_element)
        parsers << parser
      end

      parsers.each { |parser| self.add_css_parser(parser) }
    end

    def [](property)
      self.summary_declarations[property] || []
    end

    def most_decorations_selector
      self.selectors.sort { |a, b| b.declarations.count <=> a.declarations.count }.first
    end

    def add_css_parser(parser)
      parser.each_rule_set do |rule, media_types|
        self.rules.push(rule)
        self.media_types.concat(media_types)
        rule.each_selector do |selector, declarations, specificity|
          declarations = declarations.split(';').map do |declaration|
            property, value = declaration.split(':').map(&:strip)

            if self.summary_declarations.has_key?(property)
              self.summary_declarations[property].add(value.strip)
            else
              self.summary_declarations[property] = SummaryDeclaration.new(value)
            end

            Declaration.new(property, value)
          end
          self.selectors.push(Selector.new(selector, declarations))
        end
      end

      self.media_types.uniq!
      self.media_types.delete(:all)
      self.selectors.sort! { |a, b| b.identifier_count <=> a.identifier_count }
    end
  end
end
