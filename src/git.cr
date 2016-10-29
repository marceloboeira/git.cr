require "./git/*"

module Git
  def self.init(path = ".")
    system("git init #{path} &> 0")
  end
end
