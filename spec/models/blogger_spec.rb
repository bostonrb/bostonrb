require 'spec_helper'

describe Blogger do
  describe 'Validations' do
    let(:blogger) { Factory.build :blogger }
    before { blogger.stubs(:load_from_feed) }
    subject { blogger }
    it { should_not have_valid(:name).when(nil, '') }
    it { should_not have_valid(:feed_url).when('badurl') }
    it { should_not have_valid(:feed_url).when(nil) }
  end

  describe '.alphabetically' do
    let(:brian) { Factory.build :blogger, :name => 'Brian' }
    let(:pat)   { Factory.build :blogger, :name => 'Pat'   }
    let(:alex)  { Factory.build :blogger, :name => 'Alex'  }
    before do
      [brian, pat, alex].each do |blogger|
        blogger.stubs(:load_from_feed)
        blogger.save
      end
    end
    subject { Blogger.alphabetically }
    it { should == [alex, brian, pat] }
  end

  describe '#follow_on_twitter' do
    let(:brian) { Factory.build :blogger, twitter_username: '@brian' }
    before do
      brian.stubs(:load_from_feed)
    end
    it 'follows when we create a blogger with a twitter username' do
      Twitter.expects(:follow).with('@brian')
      brian.save
    end
    it 'follows when we change the twitter username' do
      Twitter.expects(:follow).with('@brian')
      brian.save
      Twitter.expects(:follow).with('@bcardarella')
      brian.twitter_username = '@bcardarella'
      brian.save
    end
    it 'does not follow when we have no twitter username' do
      Twitter.expects(:follow).never
      brian.twitter_username = nil
      brian.save
    end
  end

  describe '#tweet_new_blogger' do
    let(:brian) { Factory.build :blogger, twitter_username: '@brian' }
    before do
      brian.stubs(:load_from_feed)
    end
    it 'tweets a welcome when a new blogger is created' do
      Twitter.expects(:update).with('Introducing @brian a new Boston Rubyist blogger')
      brian.save
    end
    it "does not tweet a welcome when we do not know a new blogger's twitter name" do
      Twitter.expects(:update).never
      brian.twitter_username = nil
      brian.save
    end
  end

  describe '#load_from_feed (called after_create)' do
    let(:feed        ) { stub                                         }
    let(:feed_entries) { [stub,                 stub                ] }
    let(:posts       ) { [Factory.build(:post, blogger: brian), Factory.build(:post, blogger: brian)] }
    let(:brian       ) { Factory.build :blogger, feed_url: 'http://some.blog.com/feed'}
    before do
      feed.stubs(:etag).returns('123456789')
      feed.stubs(:title).returns('Some Blog')
      feed.stubs(:url).returns('http://some.blog.com')
      feed.stubs(:entries).returns(feed_entries)
      Feedzirra::Feed.expects(:fetch_and_parse).with('http://some.blog.com/feed').returns(feed)
      Post.expects(:new_from_entries).with(brian, feed_entries).returns(posts)

      brian.save
    end
    subject { brian }
    its(:title) { should == 'Some Blog' }
    its(:url) { should == 'http://some.blog.com' }
    its(:posts) { should == posts }
  end

  describe '#update_from_feed' do
    let(:old_post    ) { Factory.build(:post, published_at: 1.day.ago)    }
    let(:brian       ) { Factory :blogger, feed_url: 'http://some.blog.com/feed', posts: [old_post]}
    before do
      Blogger.any_instance.stubs(:load_from_feed)
    end
    describe 'when there are updates' do
      let(:new_post_1  ) { Factory.build(:post, published_at: 1.hour.ago)   }
      let(:new_post_2  ) { Factory.build(:post, published_at: 1.minute.ago) }
      let(:new_entries ) { [stub,       stub        ]                       }
      let(:new_posts   ) { [new_post_1, new_post_2  ]                       }
      before do
        Feedzirra::Parser::Atom.any_instance.stubs(:updated?).returns(true)
        Feedzirra::Parser::Atom.any_instance.stubs(:new_entries).returns(new_entries)
        Feedzirra::Feed.expects(:update)
        Post.expects(:new_from_entries).with(brian, new_entries).returns(new_posts)

        brian.update_from_feed
      end
      subject { brian }
      its(:posts) { should == [old_post, new_post_1, new_post_2] }
    end
    describe 'when there are no updates' do
      before do
        Feedzirra::Parser::Atom.any_instance.stubs(:updated?).returns(false)
        Feedzirra::Feed.expects(:update)
        Post.expects(:new_from_entries).never

        brian.update_from_feed
      end
      subject { brian }
      its(:posts) { should == [old_post] }
    end
  end

  describe '#update_all_from_feeds' do
    let(:brian) { Factory :blogger }
    let(:alex ) { Factory :blogger }
    before do
      Blogger.any_instance.stubs(:load_from_feed)
      Feedzirra::Parser::Atom.any_instance.stubs(:updated?).returns(false)
    end
    it 'should update each blogger in turn' do
      Blogger.update_all_from_feeds
    end
  end
end

