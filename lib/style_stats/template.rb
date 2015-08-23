class StyleStats
  class Template
    def initialize(css, options)
      @css = css
    end

    def render
      text = File.read "lib/style_stats/templates/default.erb"
      @paths = []
      @csses = []
      ERB.new(text).run(binding)
    end
  end
end
