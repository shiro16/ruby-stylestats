class StyleStats
  def initialize(paths, options)
    @csses = PathParser.new(paths).files.collect do |file|
      Css.new(file)
    end
  end

  def analyze
    result = @csses.inject(:+)
    Template.new(result, @options)
  end
end

require 'style_stats/version'
require 'style_stats/css'
require 'style_stats/path_parser'
require 'style_stats/template'
require 'style_stats/cli'
