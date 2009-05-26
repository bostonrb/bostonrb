require File.join(File.dirname(__FILE__), '/test_helper.rb')

class GithubUserTest < Test::Unit::TestCase
  context "A Github::User" do
    setup do
      fixture_path = File.join(File.dirname(__FILE__), 'fixtures', 'user.xml')
      FakeWeb.register_uri('http://github.com/api/v2/xml/user/search/dancroak',
                           :response => fixture_path)

      @user = Github::User.find('dancroak')
    end

    test "#score" do
      @user.score.should == 3.8653853
    end

    test "#name" do
      @user.name.should == "dancroak"
    end

    test "#actions" do
      @user.actions.should == 35
    end

    test "#language" do
      @user.language.should == "Ruby"
    end

    test "#followers" do
      @user.followers.should == 50
    end

    test "#username" do
      @user.username.should == "dancroak"
    end

    test "#type" do
      @user.type.should == "user"
    end

    test "#fullname" do
      @user.fullname.should == "Dan Croak"
    end

    test "#repos" do
      @user.repos.should == 18
    end

    test "#id" do
      @user.id.should == "user-198"
    end

    test "#pushed" do
      @user.pushed.to_s.should == DateTime.new(2009, 5, 22, 17, 15, 11).to_s
    end

    test "#created" do
      @user.created.to_s.should == DateTime.new(2008, 2, 13, 2, 48, 35).to_s
    end

    test "#location" do
      @user.location.should == "Boston"
    end

    context "GETing #repositories" do
      setup do
        fixture_path = File.join(File.dirname(__FILE__),
                                 'fixtures',
                                 'user_repositories.xml')
        FakeWeb.register_uri('http://github.com/api/v2/xml/repos/show/dancroak',
                             :response => fixture_path)

        @repositories = @user.repositories
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
      end
    end
  end
end
