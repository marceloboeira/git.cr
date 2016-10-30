module Git
  class Repository
    def self.init(path = ".")
      raise InvalidPathException.new("#{path} is not a valid path") unless Git.exec("init #{path}")
    end
  end
end
