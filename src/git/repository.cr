module Git
  class Repository
    class InvalidURIException < Exception; end
    class InvalidPathException < Exception; end

    def self.init(path = ".")
      raise InvalidPathException.new("#{path} is not a valid path") unless Git.exec("init #{path}")
    end

    def self.clone(uri)
      raise InvalidURIException.new("#{uri} is not a valid URI") unless Git.exec("clone #{uri}")
    end
  end
end
