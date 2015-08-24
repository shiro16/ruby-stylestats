class StyleStats
  class PathParser
    EXTENSIONS = ['.less', '.styl', '.stylus', '.css']

    attr_accessor :stylesheets, :style_element

    def initialize(path)
      parse(path)
    end

    private
    def parse(path)
      self.stylesheets = if path =~ URI::regexp
                           request(path)
                         else
                           files = fetch_files(path)
                           filter_extention(files)
                         end
    end

    def request(url)
      file = open(url)
      case file.content_type
      when'text/css'
        [url]
      when 'text/html'
        doc = Nokogiri::HTML(file)
        self.style_element = find_style_element(doc)
        find_stylesheets(doc, url)
      else
        raise e
      end
    end

    def fetch_files(path)
      if File.directory?(path)
        Dir::entries(path)
      else
        Dir.glob(path)
      end
    end

    def find_style_element(doc)
      doc.xpath('//style').children.to_s
    end

    def find_stylesheets(doc, url)
      base = URI.parse(url)
      doc.xpath('//link[@rel="stylesheet"]').map do |node|
        uri = URI.parse(node["href"])
        uri.scheme = 'http' unless uri.scheme
        uri.host = base.host unless uri.host
        uri.to_s
      end
    rescue
      []
      # raise StyleStats::RequestError.new()
    end

    def filter_extention(files)
      files.select { |file| EXTENSIONS.include?(File.extname(file)) }
    end
  end
end
