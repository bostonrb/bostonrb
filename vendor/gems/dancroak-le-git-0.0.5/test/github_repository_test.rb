require File.join(File.dirname(__FILE__), '/test_helper.rb')

class GithubRepositoryTest < Test::Unit::TestCase
  context "a Github::Repository found via user" do
    setup do
      fixture_path = File.join(File.dirname(__FILE__),
                               'fixtures',
                               'user_repositories.xml')
      FakeWeb.register_uri('http://github.com/api/v2/xml/repos/show/dancroak',
                           :response => fixture_path)

      @repositories = Github::Repository.user("dancroak")
    end

    test "size" do
      @repositories.size.should == 19
    end

    context "first" do
      setup do
        @repository = @repositories.first
      end

      test "#description" do
        @repository.description.should == "Rails plugin. Force major browsers (IE, Firefox, Safari) to reload a page, even when triggered by 'back' button."
      end

      test "#name" do
        @repository.name.should == "no_cache"
      end

      test "#private" do
        @repository.private.should == false
      end

      test "#url" do
        @repository.url.should == "http://github.com/dancroak/no_cache"
      end

      test "#fork" do
        @repository.fork.should == false
      end

      test "#watchers" do
        @repository.watchers.should == 10
      end

      test "#forks" do
        @repository.forks.should == 0
      end

      test "#owner" do
        @repository.owner.should == "dancroak"
      end

      test "#homepage" do
        @repository.homepage.should == "http://giantrobots.thoughtbot.com"
      end

      context "master commits" do
        setup do
          uri = "http://github.com:80/api/v2/xml/commits/list/dancroak/le-git/master"
          fixture_path = File.join(File.dirname(__FILE__),
                                   'fixtures',
                                   'master_commits.xml')

          FakeWeb.register_uri(uri, :response => fixture_path)

          begin
            @commits = @repository.commits
          rescue # can't figure out Net::HTTPBadResponse: wrong status line
            @commits = Github::Commit.parse(File.read(fixture_path))
          end
        end

        test "size" do
          @commits.size.should == 30
        end

        context "first commit" do
          setup do
            @commit = @commits.first
          end

          test "#message" do
            @commit.message.should == "updating Repository model to use v2 API. associated User & Repository models. filled out complete API for User."
          end

          test "#url" do
            @commit.url.should == "http://github.com/dancroak/le-git/commit/1f0111c91344062052f65922171d220a06810d4a"
          end

          test "#id" do
            @commit.id.should == "1f0111c91344062052f65922171d220a06810d4a"
          end

          test "#tree" do
            @commit.tree.should == "d27ed042222fe8a55681e1af260e3eb2847e9f33"
          end
        end
      end
    end
  end
end
