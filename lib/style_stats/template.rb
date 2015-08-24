class StyleStats
  class Template
    def initialize(csses, options)
      @csses = csses
    end

    def render
      text = File.read "lib/style_stats/templates/default.erb"
      @css = @csses.first
      ERB.new(text).run(binding)
    end
  end
end
