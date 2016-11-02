require "../spec_helper"
require "tmpdir"

describe Git::Repository do
  describe "init" do
    describe "when no path is given" do
      it "initializes in the current folder" do
        Dir.mktmpdir do |repository_path|
          Dir.cd(repository_path)

          respository = Git::Repository.init

          Dir.exists?("#{repository_path}/.git").should eq(true)
        end
      end
    end

    describe "when the path is given" do
      describe "and it is valid" do
        it "initializes in the given folder" do
          Dir.mktmpdir do |repository_path|
            Dir.cd("/var")

            Git::Repository.init(repository_path)

            Dir.exists?("#{repository_path}/.git").should eq(true)
          end
        end
      end

      describe "and it is invalid" do
        it "raises an expection" do
          expect_raises(Git::Repository::InvalidPathException) do
            Dir.mktmpdir do |repository_path|
              Git::Repository.init("/foo/bar/b")
            end
          end
        end
      end
    end
  end

  describe "clone" do
    describe "and the given URI is valid" do
      describe "and it is https" do
        it "creates a new folder with the repository" do
          Dir.mktmpdir do |repository_path|
            uri = "https://github.com/marceloboeira/git.cr.git"
            Dir.cd(repository_path)

            respository = Git::Repository.clone(uri)

            Dir.exists?("#{repository_path}/git.cr/.git").should eq(true)
          end
        end
      end
    end

    describe "and the given URI is invalid" do
      it "raises an exception" do
        uri = "http://invalid.com/foo/bar.git"
        expect_raises(Git::Repository::InvalidURIException) do
          Dir.mktmpdir do |repository_path|
            respository = Git::Repository.clone(uri)
          end
        end
      end
    end
  end
end
