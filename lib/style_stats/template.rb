require 'style_stats/templates/table'

class StyleStats
  class Template
    include CommandLineReporter

    def initialize(css, options = {})
      @css = css
      @options = {format: :default}
      @options.merge!(options)
    end

    def render
      case @options[:format].to_sym
      when :md, :html
        text = File.read("lib/style_stats/templates/#{@options[:format]}.erb")
        ERB.new(text, nil, '-').run(binding)
      when :json
        puts @css.analyze.to_json
      else
        Table.new(@css.analyze).run
      end
    end
  end
end
