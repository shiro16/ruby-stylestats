class StyleStats
  class CLI
    def self.run(files, options)
      stylestats = StyleStats.new(files, options)
      stylestats.render
    rescue StyleStats::RequestError
      puts '[ERROR] getaddrinfo ENOTFOUND'
    rescue StyleStats::ContentError
      puts '[ERROR] Content type is not HTML or CSS!'
    rescue StyleStats::InvalidError
      puts '[ERROR] Argument is invalid'
    end
  end
end
