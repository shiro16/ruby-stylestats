class StyleStats
  class Template
    def initialize(stylestats, options = {})
      @stylestats = stylestats
      @options = options
    end

    def render
      case @options[:format]
      when 'default'
        text = File.read "lib/style_stats/templates/default.erb"
        ERB.new(text, nil, '-').run(binding)
      else
        p @stylestats.to_hash.to_json
      end
    end
  end
end
