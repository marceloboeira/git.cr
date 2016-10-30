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
          expect_raises(Git::InvalidPathException) do
            Git::Repository.init("/foo/bar/b")
          end
        end
      end
    end
  end
end
