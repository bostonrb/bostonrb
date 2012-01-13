require 'spec_helper'

describe Blog do
  describe 'Validations' do
    let(:blog) { Factory.build :blog }
    before { blog.stubs(:load_from_feed) }
    subject { blog }
    it { should_not have_valid(:author).when(nil, '') }
    it { should_not have_valid(:twitter_username).when(nil) }
    it { should_not have_valid(:twitter_username).when('not_starting_with_at_sign') }
    it { should_not have_valid(:feed_url).when('badurl') }
    it { should_not have_valid(:feed_url).when(nil) }
  end

  describe '.alphabetically' do
    let(:brian) { Factory.build :blog, :author => 'Brian' }
    let(:pat)   { Factory.build :blog, :author => 'Pat'   }
    let(:alex)  { Factory.build :blog, :author => 'Alex'  }
    before do
      [brian, pat, alex].each do |blog|
        blog.stubs(:load_from_feed)
        blog.save
      end
    end
    subject { Blog.alphabetically }
    it { should == [alex, brian, pat] }
  end

  describe '#load_from_feed (called after_create)' do
    let(:feed        ) { stub(:etag => '123456789', :title => 'Some Blog', :url => 'http://some.blog.com', :entries => feed_entries) }
    let(:entry_1     ) { stub(:published => 1.day.ago,  :url => 'http://some.blog.com/new_post') }
    let(:entry_2     ) { stub(:published => 5.days.ago, :url => 'http://some.blog.com/old_post') }
    let(:feed_entries) { [entry_1, entry_2] }
    let(:brian_blog  ) { Factory :blog, feed_url: 'http://some.blog.com/feed'}
    before do
      Feedzirra::Feed.expects(:fetch_and_parse).with('http://some.blog.com/feed').returns(feed)
    end
    subject { brian_blog }
    its(:title) { should == 'Some Blog' }
    its(:url) { should == 'http://some.blog.com' }
    its(:most_recent_post_url) { should == 'http://some.blog.com/new_post' }
  end

  describe '#update_from_feed' do
    let(:brian_blog) { Factory.build :blog, twitter_username: '@brian', feed_url: 'http://some.blog.com/feed', most_recent_post_url: 'http://some.blog.com/old_post'}
    before do
      brian_blog.stubs(:load_from_feed)
      brian_blog.save

      Twitter.stubs(:update)
    end
    describe 'when there are updates' do
      let(:long_title      ) { 'This Title Goes On And On For Way Too Long. Why Can I Not Be More Concise? This Will Not Fit In A Tweet :(' }
      let(:short_title     ) { 'Something Short and Sweet' }
      let(:new_entry       ) { stub(:published => 1.day.ago,  :url => 'http://some.blog.com/newest_post', :categories => ['ruby'], :title => long_title ) }
      let(:irrelevant_entry) { stub(:published => 2.days.ago, :url => 'http://some.blog.com/php_post',    :categories => ['php' ], :title => 'PHP stuff') }
      let(:newer_entry     ) { stub(:published => 5.days.ago, :url => 'http://some.blog.com/new_post',    :categories => ['ruby'], :title => short_title) }
      let(:old_entry       ) { stub(:published => 1.month.ago) }
      let(:new_entries     ) { [newer_entry, new_entry] }
      before do
        Feedzirra::Parser::Atom.any_instance.stubs(:updated?).returns(true)
        Feedzirra::Parser::Atom.any_instance.stubs(:new_entries).returns(new_entries)
        Feedzirra::Parser::Atom.any_instance.stubs(:entries).returns([newer_entry, irrelevant_entry, new_entry, old_entry])
        Feedzirra::Feed.expects(:update)

        brian_blog.update_from_feed
      end
      subject { brian_blog }
      its(:most_recent_post_url) { should == 'http://some.blog.com/newest_post' }
      describe 'tweeting' do
        subject { Twitter }
        it { should have_received(:update).with('Boston Rubyist @brian just blogged about Something Short and Sweet http://some.blog.com/new_post') }
        it { should have_received(:update).with('Boston Rubyist @brian just blogged about This Title Goes On And On For Way Too Long. Why Can I Not Be More Concise? ... http://some.blog.com/newest_post') }
        it { should_not have_received(:update).with('Boston Rubyist @brian just blogged about PHP stuff http://some.blog.com/php_post') }
      end
    end
    describe 'when there are no updates' do
      before do
        Feedzirra::Parser::Atom.any_instance.stubs(:updated?).returns(false)
        Feedzirra::Feed.expects(:update)

        brian_blog.update_from_feed
      end
      subject { brian_blog }
      its(:most_recent_post_url) { should == 'http://some.blog.com/old_post' }
      describe 'tweeting' do
        subject { Twitter }
        it { should_not have_received(:update) }
      end
    end
  end

  describe '#update_all_from_feeds' do
    let(:brian) { Factory :blog }
    let(:alex ) { Factory :blog }
    before do
      Blog.any_instance.stubs(:load_from_feed)
      Feedzirra::Parser::Atom.any_instance.stubs(:updated?).returns(false)
    end
    it 'should update each blog in turn' do
      Blog.update_all_from_feeds
    end
  end
end
