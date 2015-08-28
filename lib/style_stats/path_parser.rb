class StyleStats
  class PathParser
    EXTENSIONS = ['.less', '.styl', '.stylus', '.css']

    attr_accessor :files

    def initialize(path)
      self.files = parse(path)
    end

    private
    def parse(path)
      if path =~ URI::regexp
        [path]
      elsif File.file?(path)
        raise InvalidError.new if filter_extention([path]).empty?
        [path]
      else
        filter_extention(parse_files(path))
      end
    end

    def fetch_files(path)
      if File.directory?(path)
        Dir::entries(path)
      else
        Dir.glob(path)
      end
    end

    def filter_extention(files)
      files.select { |file| EXTENSIONS.include?(File.extname(file)) }
    end
  end
end
