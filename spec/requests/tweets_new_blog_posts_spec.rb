require 'spec_helper'

feature 'BostonRB Blogs', %{
  As a BostonRB member
  I want to see ruby posts by BostonRB bloggers tweeted by the @bostonrb account
} do

  include Blog::TestHelpers
  let(:blog_feed_directory) { "#{Rails.root}/tmp/blog_feeds" }
  let(:alex_blog ) { create(:blog, :author => 'Alex',  :twitter_username => '@alex',  :feed_url => "file://#{blog_feed_directory}/alex_atom.xml"          ) }
  let(:pat_blog  ) { create(:blog, :author => 'Pat',   :twitter_username => '@pat',   :feed_url => "file://#{blog_feed_directory}/pat_feedburner_atom.xml") }
  let(:brian_blog) { create(:blog, :author => 'Brian', :twitter_username => '@brian', :feed_url => "file://#{blog_feed_directory}/brian_rss.xml"          ) }

  background do
    FakeTwitter.activate!

    setup_blog_feeds('12_01_2011')
    [alex_blog, pat_blog, brian_blog] # lazy load them now
  end

  scenario 'Not tweeting when there are no new posts' do
    setup_blog_feeds('12_01_2011')
    Blog.update_all_from_feeds

    Twitter.fake_tweets.should be_empty
  end

  scenario 'Tweeting new ruby posts from all blogs' do
    setup_blog_feeds('1_11_2012')
    Blog.update_all_from_feeds

    Twitter.fake_tweets.should include 'Boston Rubyist @alex just blogged about My Second Ruby Post http://alex.com/2011/second_ruby_post.html'
    Twitter.fake_tweets.should include 'Boston Rubyist @alex just blogged about My First Ruby Post http://alex.com/2011/first_ruby_post.html'
    Twitter.fake_tweets.should include 'Boston Rubyist @pat just blogged about How to Customize Twitter Bootstrap http://patshaughnessy.net/2012/1/11/twitter-bootstrap'
    Twitter.fake_tweets.should include 'Boston Rubyist @brian just blogged about New Ruby stuff http://bcardarella.com/post/8682011111'
    Twitter.fake_tweets.size.should == 4
  end

end
