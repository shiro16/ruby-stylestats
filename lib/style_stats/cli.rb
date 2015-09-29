class StyleStats
  class CLI
    class << self
      def run(files, option)
        @options = option
        StyleStats.configure do |config|
          config.options[:requestOptions][:headers]['User-Agent'] = user_agent
          config.options.merge!(configuration)
        end

        stylestats = StyleStats.new(files, options)
        stylestats.render
      rescue StyleStats::RequestError
        puts '[ERROR] getaddrinfo ENOTFOUND'
      rescue StyleStats::ContentError
        puts '[ERROR] Content type is not HTML or CSS!'
      rescue StyleStats::InvalidError
        puts '[ERROR] Argument is invalid'
      end

      private
      def options
        {
          format: @options[:format]
        }
      end

      def user_agent
        case @options[:user_agent]
        when 'ios'
          'Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/600.1.4 Version/8.0 Safari/600.1.4'
        when 'android'
          'Mozilla/5.0 (Linux; Android 4.4.2; Nexus 5 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.99 Mobile Safari/537.36'
        else
          @options[:user_agent]
        end
      end

      def configuration
        config = case File.extname(@options[:config].to_s)
                 when '.yml', '.yaml'
                   YAML.load_file(@options[:config])
                 when '.json'
                   json = File.read(@options[:config])
                   JSON.parse(json)
                 else
                   {}
                 end
      end
    end
  end
end
