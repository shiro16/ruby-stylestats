require 'nokogiri'
require 'open-uri'
class StyleStats
  class PathParser
    EXTENSIONS = ['.less', '.styl', '.stylus', '.css']

    attr_accessor :files

    def initialize(paths)
      paths = [paths] unless paths.is_a?(Array)

      self.files = paths.map do |path|
        files = parse(path)
        filter_extention(files)
      end.inject(:+)
    end

    private
    def parse(path)
      if path =~ URI::regexp
        EXTENSIONS.include?(File.extname(path)) ? [path] : find_css_by_response(path)
      elsif File.directory?(path)
        Dir::entries(path)
      else
        Dir.glob(path)
      end
    end

    def find_css_by_response(path)
       Nokogiri::HTML(open(path)).xpath('//link[@rel="stylesheet"]').map do |node|
         node["href"]
       end
    rescue => e
      p e
      # raise StyleStats::RequestError.new()
    end

    def filter_extention(files)
      files.select { |file| EXTENSIONS.include?(File.extname(file)) }
    end
  end
end
