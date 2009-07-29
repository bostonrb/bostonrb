require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Feed do
  it { should validate_presence_of(:feed_url) }
  it { should have_many(:entries).dependent(:destroy) }
  it { should have_many(:feed_errors) }

  describe "normalize_feed_url" do
    it "should prepend http if feed_url is missing it" do
      feed = Feed.new(:feed_url => 'example.com/atom')

      feed.normalize_feed_url

      feed.feed_url_changed?.should be_true
      feed.feed_url.should == 'http://example.com/atom'
    end

    it "should not change if feed_url is nil" do
      feed = Feed.new(:feed_url => nil)

      feed.normalize_feed_url

      feed.feed_url.should == nil
    end

    it "should not change if feed_url is a empty string" do
      feed = Feed.new(:feed_url => "")

      feed.normalize_feed_url

      feed.feed_url.should == ""
    end
  end

  describe "fetch!" do
    it "should create a feed error if feedzirra returns a number" do
      feed = Feed.new(:feed_url => 'http://example.com/atom')

      stub(Feedzirra::Feed).fetch_and_parse('http://example.com/atom') { 404 }

      mock(feed).create_feed_error_from_exception(404)

      feed.fetch!
    end

    it "should create a feed error if feedzirra returns nil" do
      feed = Feed.new(:feed_url => 'http://example.com/atom')

      stub(Feedzirra::Feed).fetch_and_parse('http://example.com/atom') { nil }

      mock(feed).create_feed_error_from_exception(nil)

      feed.fetch!
    end

    it "should create a feed error if feedzirra raises an error" do
      feed = Feed.new(:feed_url => 'http://example.com/atom')

      error = RuntimeError.new("zomg")
      stub(Feedzirra::Feed).fetch_and_parse('http://example.com/atom') { raise error }

      mock(feed).create_feed_error_from_exception(error)

      feed.fetch!
    end

    it "should create entries from feedzirra entries" do
      feed = Feed.new(:feed_url => 'http://example.com/atom')

      feedzirra_feed = "fake feed"
      feedzirra_entries = "fake entries"
      stub(feedzirra_feed).entries { feedzirra_entries }

      stub(Feedzirra::Feed).fetch_and_parse('http://example.com/atom') { feedzirra_feed }

      mock(feedzirra_feed).sanitize_entries!

      mock(feed).create_entries_from_feedzirra_entries(feedzirra_entries)

      feed.fetch!
    end
  end

end
