require "./git/*"

module Git
  def self.init
    system("git init &> 0")
  end
end
