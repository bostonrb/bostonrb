require 'test_helper'

class CronTest < Test::Unit::TestCase
  context "Cron.get_tweets" do
    setup do
      @client = stub('client')
      TwitterSearch::Client.stubs(:new).returns(@client)

      @user   = Factory(:user, :twitter => "Croaky")
      User.stubs(:twitter_present).returns([@user])

      Search  = Struct.new(:text, :id, :created_at)
      @god    = Search.new("god",  1, "Mon, 18 May 2009 00:00:00 +0000")
      @fear   = Search.new("fear", 2, "Tue, 19 May 2009 00:00:00 +0000")
      @tweets = [@god, @fear]
      @client.stubs(:query).returns(@tweets)

      Cron.get_tweets
    end

    should "create Tweets" do
      assert tweet = Tweet.find_by_twitter_id(1)
      assert_equal "god", tweet.text
      assert_equal DateTime.new(2009, 5, 18).to_s(:db),
                   tweet.tweeted_at.to_s(:db)

      assert tweet = Tweet.find_by_twitter_id(2)
      assert_equal "fear", tweet.text
      assert_equal DateTime.new(2009, 5, 19).to_s(:db),
                   tweet.tweeted_at.to_s(:db)
    end

    teardown do
      Tweet.destroy_all
      User.destroy_all
    end
  end

  context "Cron.get_projects" do
    setup do
      @user   = Factory(:user, :github => "dancroak")
      User.stubs(:github_present).returns([@user])

      @github_user = stub('github_user')
      Github::User.stubs(:find).with(@user.github).returns(@github_user)

      repos_path = File.join(File.dirname(__FILE__), '..', 'fixtures', 'user_repositories.xml')
      @repos  = Github::Repository.parse(IO.read(repos_path))
      @github_user.stubs(:repositories).returns(@repos)

      Cron.get_projects
    end

    should "create the no_cache project for user" do
      assert project = Project.find_by_name("no_cache")
      assert_equal @user,         project.user
      assert_equal 10,            project.watchers
      assert_equal "no_cache",    project.name
      assert_equal "http://github.com/dancroak/no_cache", project.github_url
      assert_equal "Rails plugin. Force major browsers (IE, Firefox, Safari) to reload a page, even when triggered by 'back' button.", project.description
    end

    teardown do
      Project.destroy_all
      User.destroy_all
    end
  end
end
