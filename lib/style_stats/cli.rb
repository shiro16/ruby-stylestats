class StyleStats
  class CLI
    def self.run(files, options)
      stylestats = StyleStats.new(files, options)
      stylestats.parse
    end
  end
end
