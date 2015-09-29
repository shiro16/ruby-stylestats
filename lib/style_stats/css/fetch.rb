class StyleStats::Css
  class Fetch
    attr_accessor :stylesheets, :elements

    def initialize(path)
      self.stylesheets = []
      self.elements = []
      get(path)
    end

    private
    def get(path)
      if path =~ URI::regexp
        request(path)
      else
        self.stylesheets.push(open(path).read)
      end
    end

    def request(path)
      file = open(path, headers)
      case file.content_type
      when 'text/css'
        self.stylesheets.push(file.read)
      when 'text/html'
        doc = Oga.parse_html(file.read)
        find_stylesheets(doc, path).each { |file| request(file) }
        self.elements = find_elements(doc)
      else
        raise StyleStats::ContentError.new
      end
    rescue SocketError, RuntimeError
      raise StyleStats::RequestError.new
    end

    def find_elements(doc)
      doc.xpath('//style').map(&:text)
    end

    def find_stylesheets(doc, url)
      base = URI.parse(url)
      doc.xpath('//link[@rel="stylesheet"]').map do |node|
        uri = URI.parse(node.get("href"))
        uri.scheme = 'http' unless uri.scheme
        uri.host = base.host unless uri.host
        uri.port = base.port unless uri.port
        uri.to_s
      end
    end

    def headers
      if StyleStats.configuration.options[:requestOptions][:headers]['User-Agent']
        StyleStats.configuration.options[:requestOptions][:headers]
      else
        { 'User-Agent' => "Ruby/StyleStats #{StyleStats::VERSION}" }
      end
    end
  end
end
