class StyleStats
  class PathParser
    EXTENSIONS = ['.less', '.styl', '.stylus', '.css']

    attr_accessor :stylesheets, :style_elements

    def initialize(path)
      self.style_elements = []
      parse(path)
    end

    private
    def parse(path)
      files = if path =~ URI::regexp
                request(path)
              else
                files = fetch_files(path)
                filter_extention(files)
              end
      self.stylesheets = files.map { |file| open(file).read }
    end

    def request(url)
      file = open(url)
      case file.content_type
      when'text/css'
        [url]
      when 'text/html'
        doc = Nokogiri::HTML(file)
        self.style_elements = find_style_elements(doc)
        find_stylesheets(doc, url)
      else
        raise ContentError.new(' [ERROR] Content type is not HTML or CSS!')
      end
    rescue SocketError
      raise RequestError.new(' [ERROR] getaddrinfo ENOTFOUND')
    end

    def fetch_files(path)
      if File.directory?(path)
        Dir::entries(path)
      else
        Dir.glob(path)
      end
    end

    def find_style_elements(doc)
      doc.xpath('//style').children
    end

    def find_stylesheets(doc, url)
      base = URI.parse(url)
      doc.xpath('//link[@rel="stylesheet"]').map do |node|
        uri = URI.parse(node["href"])
        uri.scheme = 'http' unless uri.scheme
        uri.host = base.host unless uri.host
        uri.port = base.port unless uri.port
        uri.to_s
      end
    end

    def filter_extention(files)
      files.select { |file| EXTENSIONS.include?(File.extname(file)) }
    end
  end
end
