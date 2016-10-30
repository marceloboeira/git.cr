require "./git/*"

module Git
  @@binary : String = `which git`.strip

  class InvalidBinaryException < Exception; end

  def self.binary=(path)
    @@binary = path.strip
  end

  def self.exec(command)
    raise InvalidBinaryException.new("#{@@binary} is an invalid file") unless system("#{@@binary} --version &> /dev/null")

    system("#{@@binary} #{command.strip} &> /dev/null")
  end
end
