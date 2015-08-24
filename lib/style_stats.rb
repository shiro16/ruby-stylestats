require 'erb'
require 'nokogiri'
require 'open-uri'
require 'css_parser'
require 'json'

class StyleStats
  def initialize(paths, options = {})
    @options = options
    paths = [paths] unless paths.is_a?(Array)
    @csses = paths.collect do |file|
      Css.new(file)
    end
  end

  def to_hash
    css = @csses.first
    {
      "Paths"                           => @csses.map(&:path),
      "Style Sheets"                    =>  @csses.count,
      "Style Elements"                  => 'スタイルタグ(URL指定でhtmlにstyle tagがあった場合)',
      "Size"                            =>  @csses.map(&:size).inject(:+),
      "Data URI Size"                   => 'data:image/....のサイズ',
      "Ratio of Data URI Size"          => 'dataUriSize / this.cssSize',
      "Gzipped Size"                    => 'gzip',
      "Rules"                           => css.rules.count,
      "Selectors"                       => css.selectors.count,
      "Declarations"                    => css.selectors.map(&:declarations).flatten.count,
      "Simplicity"                      => (css.rules.count / css.selectors.count.to_f * 100).round(1),
      "Average of Identifier"           => (css.selectors.map(&:identifier_count).inject(:+) / css.selectors.count.to_f).round(3),
      "Most Identifier"                 => css.selectors.first.identifier_count,
      "Most Identifier Selector"        => css.selectors.first.name,
      "Average of Cohesion"             => (css.selectors.map(&:declarations).flatten.count / css.rules.count.to_f).round(3),
      "Lowest Cohesion"                 => css.most_decorations_selector.declarations.count,
      "Lowest Cohesion Selector"        => css.most_decorations_selector.name,
      "Total Unique Font Sizes"         => css["font-size"].values.count,
      "Unique Font Sizes"               => css["font-size"].values,
      "Total Unique Font Families"      => css["font-family"].values.count,
      "Unique Font Families"            => css["font-family"].values,
      "Total Unique Colors"             => css["color"].values.count,
      "Unique Colors"                   => css["color"].values,
      "ID Selectors"                    => css.selectors.count { |selector| selector.name.match(/#/) },
      "Universal Selectors"             => css.selectors.count { |selector| selector.name.match(/\*/) },
      "Unqualified Attribute Selectors" => css.selectors.count { |selector| selector.name.match(/\[.+\]$/) },
      "JavaScript Specific Selectors"   => css.selectors.count { |selector| selector.name.match(/[#\\.]js\\-/) },
      "Important Keywords"              => "declaration.value indexOf('!important') count",
      "Float Properties"                => "declaration property float count",
      "Properties Count"                => css.summary_declarations.take(10).map{ |property, declaration| "#{property}: #{declaration.values.count}" },
      "Media Queries"                   => css.media_types.count
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
