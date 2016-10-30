require "./spec_helper"
require "file_utils"
require "secure_random"

describe Git do
  describe "when the git binary is not valid" do
    it "raises an error" do
      Git.binary = "invalid/path/git"

      expect_raises(Git::InvalidBinaryException) do
        Git.init
      end

      Git.binary = `which git`.strip
    end
  end

  describe "init" do
    describe "when no path is given" do
      it "initializes in the current folder" do
        repository_path = "/tmp/foo/bar/#{SecureRandom.hex}"
        Dir.mkdir_p(repository_path)
        Dir.cd(repository_path)

        Git.init

        Dir.exists?("#{repository_path}/.git").should eq(true)

        FileUtils.rm_r(repository_path)
      end
    end

    describe "when the path is given" do
      describe "and it is valid" do
        it "initializes in the given folder" do
          repository_path = "/tmp/foo/bar/#{SecureRandom.hex}"
          Dir.mkdir_p(repository_path)
          Dir.cd("/tmp")

          Git.init(repository_path)

          Dir.exists?("#{repository_path}/.git").should eq(true)

          FileUtils.rm_r(repository_path)
        end
      end

      describe "and it is invalid" do
        it "raises an expection" do
          expect_raises(Git::InvalidPathException) do
            Git.init("/foo/bar/b")
          end
        end
      end
    end
  end
end
