require "../spec_helper"

describe Git::Repository do
  describe "init" do
    describe "when no path is given" do
      it "initializes in the current folder" do
        repository_path = "/tmp/foo/bar/#{SecureRandom.hex}"
        Dir.mkdir_p(repository_path)
        Dir.cd(repository_path)

        respository = Git::Repository.init

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

          Git::Repository.init(repository_path)

          Dir.exists?("#{repository_path}/.git").should eq(true)

          FileUtils.rm_r(repository_path)
        end
      end

      describe "and it is invalid" do
        it "raises an expection" do
          expect_raises(Git::Repository::InvalidPathException) do
            Git::Repository.init("/foo/bar/b")
          end
        end
      end
    end
  end

  describe "clone" do
    describe "and the given URI is valid" do
      describe "and it is https" do
        it "creates a new folder with the repository" do
          uri = "https://github.com/marceloboeira/git.cr.git"
          repository_dir = "/tmp/foo/bar/#{SecureRandom.hex}"
          Dir.mkdir_p(repository_dir)
          Dir.cd(repository_dir)

          respository = Git::Repository.clone(uri)

          Dir.exists?("#{repository_dir}/git.cr/.git").should eq(true)

          FileUtils.rm_r(repository_dir)
        end
      end
    end

    describe "and the given URI is invalid" do
      it "raises an exception" do
        expect_raises(Git::Repository::InvalidURIException) do
          uri = "http://invalid.com/foo/bar.git"
          repository_dir = "/tmp/foo/bar/#{SecureRandom.hex}"
          Dir.mkdir_p(repository_dir)
          Dir.cd(repository_dir)

          respository = Git::Repository.clone(uri)

          Dir.exists?("#{repository_dir}/git.cr/.git").should eq(true)

          FileUtils.rm_r(repository_dir)
        end
      end
    end
  end
end
