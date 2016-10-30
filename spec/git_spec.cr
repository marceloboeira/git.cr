require "./spec_helper"

describe Git do
  describe "when the git binary is not valid" do
    it "raises an error" do
      Git.binary = "invalid/path/git"

      expect_raises(Git::InvalidBinaryException) do
        Git.exec("--version")
      end

      Git.binary = `which git`.strip
    end
  end
end
