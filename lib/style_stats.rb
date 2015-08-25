require 'erb'
require 'nokogiri'
require 'open-uri'
require 'css_parser'
require 'json'

class StyleStats
  def initialize(paths, options = {})
    paths = [paths] unless paths.is_a?(Array)
    @options = options
    @css = paths.inject(Css.new) do |css, file|
      css.merge!(Css.new(file))
    end
  end

  def to_hash
    selector = @css.sort_selector_by_declarations_count.first
    {
      "Paths"                           => @css.paths,
      "Style Sheets"                    => @css.stylesheets.count,
      "Style Elements"                  => @css.elements.count,
      "Size"                            => @css.size,
      "Data URI Size"                   => @css.data_uri_size,
      "Ratio of Data URI Size"          => "#{@css.data_uri_size.fdiv(@css.size).round(1) * 100}%",
      "Gzipped Size"                    => @css.gzipped_size,
      "Rules"                           => @css.rules.count,
      "Selectors"                       => @css.selectors.count,
      "Declarations"                    => @css.declarations.count,
      "Simplicity"                      => "#{@css.rules.count.fdiv(@css.selectors.count).round(1) * 100}%",
      "Average of Identifier"           => @css.selectors.map(&:identifier_count).inject(:+).fdiv(@css.selectors.count).round(3),
      "Most Identifier"                 => @css.selectors.first.identifier_count,
      "Most Identifier Selector"        => @css.selectors.first.name,
      "Average of Cohesion"             => @css.declarations.count.fdiv(@css.rules.count).round(3),
      "Lowest Cohesion"                 => selector.declarations.count,
      "Lowest Cohesion Selector"        => selector.name,
      "Total Unique Font Sizes"         => @css["font-size"][:count],
      "Unique Font Sizes"               => @css["font-size"][:values],
      "Total Unique Font Families"      => @css["font-family"][:count],
      "Unique Font Families"            => @css["font-family"][:values],
      "Total Unique Colors"             => @css["color"][:count],
      "Unique Colors"                   => @css["color"][:values],
      "ID Selectors"                    => @css.selectors_count(:id),
      "Universal Selectors"             => @css.selectors_count(:universal),
      "Unqualified Attribute Selectors" => @css.selectors_count(:unqualified),
      "JavaScript Specific Selectors"   => @css.selectors_count(:js),
      "Important Keywords"              => @css.declarations_count(:important),
      "Float Properties"                => @css.declarations_count(:float),
      "Properties Count"                => @css.aggregate_declarations.declarations.take(10).map{ |property, declaration| "#{property}: #{declaration[:count]}" },
      "Media Queries"                   => @css.media_types.count
    }
  end

  def analyze
    Template.new(self, @options).render
  end
end

require 'style_stats/version'
require 'style_stats/css'
require 'style_stats/path_parser'
require 'style_stats/template'
require 'style_stats/cli'
