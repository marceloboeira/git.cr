require "./spec_helper"
require "file_utils"
require "secure_random"

describe Git do
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
      it "initializes in the given folder" do
        repository_path = "/tmp/foo/bar/#{SecureRandom.hex}"
        Dir.mkdir_p(repository_path)
        Dir.cd("/tmp")

        Git.init(repository_path)

        Dir.exists?("#{repository_path}/.git").should eq(true)

        FileUtils.rm_r(repository_path)
      end
    end
  end
end
