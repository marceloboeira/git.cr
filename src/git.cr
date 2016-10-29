require "./git/*"

module Git
  class InvalidPathException < Exception; end
  def self.init(path = ".")
    raise InvalidPathException.new("{path} is not a valid path") unless system("git init #{path} &> 0")
  end
end
