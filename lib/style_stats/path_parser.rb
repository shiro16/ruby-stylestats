class StyleStats
  class PathParser
    EXTENSIONS = ['.less', '.styl', '.stylus', '.css']

    attr_accessor :files

    def initialize(paths)
      files = paths
    end
  end
end
