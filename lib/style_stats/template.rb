require 'style_stats/templates/table'

class StyleStats
  class Template
    include CommandLineReporter

    def initialize(css, options = {})
      @css = css
      @options = {format: :default}
      options[:format] = :template if options[:template]
      @options.merge!(options)
    end

    def render
      case @options[:format].to_s.to_sym
      when :md, :html
        text = File.read("#{File.dirname(__FILE__)}/templates/#{@options[:format]}.erb")
        ERB.new(text, nil, '-').run(binding)
      when :json
        puts @css.analyze.to_json
      when :template
        text = File.read(@options[:template])
        ERB.new(text, nil, '-').run(binding)
      else
        Table.new(@css.analyze).run
      end
    end
  end
end
