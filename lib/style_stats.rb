require 'erb'
require 'oga'
require 'open-uri'
require 'css_parser'
require 'json'
require 'command_line_reporter'
require 'yaml'

class StyleStats
  def self.configure(&block)
    yield(configuration)
  end

  def self.configuration
    @_configuration ||= StyleStats::Configuration.new
  end

  def initialize(paths, options = {})
    paths = [paths] unless paths.is_a?(Array)

    @options = options

    files = paths.map do |path|
      PathParser.new(path).files
    end.flatten

    @css = files.inject(Css.new) do |css, file|
      css.merge!(Css.new(file, css_options))
    end
  end

  def render
    Template.new(@css, template_options).render
  end

  private
  def css_options
    {
      user_agent: @options[:user_agent]
    }
  end

  def template_options
    {
      format: @options[:format]
    }
  end
end

require 'style_stats/version'
require 'style_stats/configuration'
require 'style_stats/path_parser'
require 'style_stats/css'
require 'style_stats/template'
require 'style_stats/errors'
require 'style_stats/cli'
