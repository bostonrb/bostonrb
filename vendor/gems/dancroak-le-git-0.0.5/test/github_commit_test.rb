require File.join(File.dirname(__FILE__), '/test_helper.rb')

class GithubCommitTest < Test::Unit::TestCase
  context "given a repository, master commits" do
    setup do
      uri = "http://github.com:80/api/v2/xml/commits/list/dancroak/le-git/master"
      fixture_path = File.join(File.dirname(__FILE__),
                               'fixtures',
                               'master_commits.xml')

      FakeWeb.register_uri(uri, :response => fixture_path)

      begin
        @commits = Github::Commit.master("dancroak", "le-git")
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

      test "#parents size" do
        pending "how to do arrays?" do
          @commit.parents.size.should == 1
          @commits.parents.first.id.should == "690c79a261ed5b078c08742b796cb3056f685698"
        end
      end

      test "#url" do
        @commit.url.should == "http://github.com/dancroak/le-git/commit/1f0111c91344062052f65922171d220a06810d4a"
      end

      test "#author" do
        pending "how to do arrays?" do
          @commit.author.name.should == "Dan Croak"
          @commit.author.email.should == "dcroak@thoughtbot.com"
        end
      end

      test "#id" do
        @commit.id.should == "1f0111c91344062052f65922171d220a06810d4a"
      end

      test "#commited_date" do
        pending "HappyMapper can't handle nodes with dashes" do
          @commit.committed_date.should == Date.parse("2009-05-25T19:11:27-07:00")
        end
      end

      test "#authored_date" do
        pending "HappyMapper can't handle nodes with dashes" do
          @commit.authored_date.should == Date.parse("2009-05-25T19:11:27-07:00")
        end
      end

      test "#tree" do
        @commit.tree.should == "d27ed042222fe8a55681e1af260e3eb2847e9f33"
      end

      test "#committer" do
        pending "how to do arrays?" do
          @commit.committer.name.should == "Dan Croak"
          @commit.committer.email.should == "dcroak@thoughtbot.com"
        end
      end
    end
  end
end
