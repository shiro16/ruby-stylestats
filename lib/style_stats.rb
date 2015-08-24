require 'erb'
require 'nokogiri'
require 'open-uri'
require 'css_parser'

class StyleStats
  def initialize(paths, options)
    paths = [paths] unless paths.is_a?(Array)
    @csses = paths.collect do |file|
      Css.new(file)
    end
  end

  def analyze
    Template.new(@csses, @options).render
  end
end

require 'style_stats/version'
require 'style_stats/css'
require 'style_stats/path_parser'
require 'style_stats/template'
require 'style_stats/cli'
