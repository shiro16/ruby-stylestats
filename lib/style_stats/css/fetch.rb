class StyleStats::Css
  class Fetch
    attr_accessor :stylesheets, :elements

    def initialize(path, options={})
      self.stylesheets = []
      self.elements = []
      @options = options
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
      file = open(path, "User-Agent" => user_agent)
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
    rescue
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

    def user_agent
      @options[:user_agent] || "Ruby/StyleStats #{StyleStats::VERSION}"
    end
  end
end
