require "./git/*"

module Git
  @@binary : String = `which git`.strip

  class InvalidPathException < Exception; end
  class InvalidBinaryException < Exception; end

  def self.init(path = ".")
    raise InvalidPathException.new("#{path} is not a valid path") unless exec("init #{path}")
  end

  def self.binary=(path)
    @@binary = path.strip
  end

  def self.exec(command)
    raise InvalidBinaryException.new("#{@@binary} is an invalid file") unless system("#{@@binary} --version &> /dev/null")

    system("#{@@binary} #{command.strip} &> /dev/null")
  end
end
