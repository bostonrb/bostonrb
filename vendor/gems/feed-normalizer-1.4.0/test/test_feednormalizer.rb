require 'test/unit'
require 'feed-normalizer'
require 'yaml'

include FeedNormalizer

class FeedNormalizerTest < Test::Unit::TestCase

  XML_FILES = {}

  data_dir = File.dirname(__FILE__) + '/data'

  # Load up the xml files
  Dir.open(data_dir).each do |fn|
    next unless fn =~ /[.]xml$/
    XML_FILES[fn.scan(/(.*)[.]/).to_s.to_sym] = File.read(data_dir + "/#{fn}")
  end

  def test_basic_parse
    assert_kind_of Feed, FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20])
  end

  def test_force_parser
    assert_kind_of Feed, FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20],
      :force_parser => RubyRssParser, :try_others => true)
  end

  def test_force_parser_exclusive
    assert_kind_of Feed, FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20],
      :force_parser => RubyRssParser, :try_others => false)
  end

  def test_ruby_rss_parser
    assert_kind_of Feed, FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20],
      :force_parser => RubyRssParser, :try_others => false)
    assert_kind_of Feed, FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rdf10],
      :force_parser => RubyRssParser, :try_others => false)
  end

  def test_simple_rss_parser
    assert_kind_of Feed, FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20],
      :force_parser => SimpleRssParser, :try_others => false)
    assert_kind_of Feed, FeedNormalizer::FeedNormalizer.parse(XML_FILES[:atom10],
      :force_parser => SimpleRssParser, :try_others => false)
  end

  def test_parser_failover_order
    assert_equal 'SimpleRSS', FeedNormalizer::FeedNormalizer.parse(XML_FILES[:atom10], :force_parser => RubyRssParser).parser
  end

  def test_force_parser_fail
    assert_nil FeedNormalizer::FeedNormalizer.parse(XML_FILES[:atom10], :force_parser => RubyRssParser, :try_others => false)
  end

  def test_all_parsers_fail
    assert_nil FeedNormalizer::FeedNormalizer.parse("This isn't RSS or Atom!")
  end

  def test_correct_parser_used
    assert_equal 'RSS::Parser', FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20]).parser
    assert_equal 'SimpleRSS', FeedNormalizer::FeedNormalizer.parse(XML_FILES[:atom10]).parser
  end

  def test_rss
    feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20])

    assert_equal "BBC News | Technology | UK Edition", feed.title
    assert_equal ["http://news.bbc.co.uk/go/rss/-/1/hi/technology/default.stm"], feed.urls
    assert_equal "MP3 player court order overturned", feed.entries.last.title
    assert_equal "SanDisk puts its MP3 players back on display at a German electronics show after overturning a court injunction.", feed.entries.last.description
    assert_match(/test\d/, feed.entries.last.content)
    assert_instance_of Time, feed.entries.last.date_published
  end

  def test_simplerss
    feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[:atom10])

    assert_equal "~:caboose", feed.title
    assert_equal "http://habtm.com/xml/atom10/feed.xml", feed.url
    assert_equal "Starfish - Easy Distribution of Site Maintenance", feed.entries.last.title
    assert_equal "urn:uuid:6c028f36-f87a-4f53-b7e3-1f943d2341f0", feed.entries.last.id

    assert !feed.entries.last.description.include?("google fame")
    assert feed.entries.last.content.include?("google fame")
  end

  def test_sanity_check
    XML_FILES.keys.each do |xml_file|
      feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[xml_file])

      assert [feed.parser, feed.title, feed.url, feed.entries.first.url].collect{|e| e.is_a?(String)}.all?, "Not everything was a String in #{xml_file}"
    end
  end

  def test_feed_equality
    assert_equal FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20]), FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20])
    assert_equal FeedNormalizer::FeedNormalizer.parse(XML_FILES[:atom10]), FeedNormalizer::FeedNormalizer.parse(XML_FILES[:atom10])
    assert_not_equal FeedNormalizer::FeedNormalizer.parse(XML_FILES[:atom03]), FeedNormalizer::FeedNormalizer.parse(XML_FILES[:atom10])
    assert_not_equal FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20]), FeedNormalizer::FeedNormalizer.parse(XML_FILES[:atom10])
    assert_not_equal FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20]), FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20diff])
  end

  def test_feed_diff
    feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20])

    diff = feed.diff(FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20diff]))
    diff_short = feed.diff(FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20diff_short]))
    no_diff = feed.diff(feed)

    assert diff.keys.all? {|key| [:title, :items].include?(key)}
    assert_equal 3, diff[:items].size

    assert diff_short.keys.all? {|key| [:title, :items].include?(key)}
    assert_equal [3,2], diff_short[:items]

    assert no_diff.empty?
  end

  def test_marshal
    feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20])

    assert_nothing_raised { Marshal.load(Marshal.dump(feed)) }
  end

  def test_yaml
    feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20])
    assert_nothing_raised { YAML.load(YAML.dump(feed)) }
  end

  def test_method_missing
    assert_raise(NoMethodError) { Feed.new(nil).nonexistant }
  end

  def test_clean
    feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[:atom10])

    assert feed.entries.first.content !~ /\<p\>/
    feed.clean!
    assert feed.entries.first.content =~ /\<p\>/
  end

  def test_malformed_feed
    assert_nothing_raised { FeedNormalizer::FeedNormalizer.parse('<feed></feed>') }
  end

  def test_dublin_core_date_ruby_rss
    feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rdf10], :force_parser => RubyRssParser, :try_others => false)
    assert_equal 'RSS::Parser', feed.parser
    assert_instance_of Time, feed.entries.first.date_published
  end

  def test_dublin_core_date_simple_rss
    feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rdf10], :force_parser => SimpleRssParser, :try_others => false)
    assert_equal 'SimpleRSS', feed.parser
    assert_instance_of Time, feed.entries.first.date_published
  end

  def test_dublin_core_creator_ruby_rss
    feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rdf10], :force_parser => RubyRssParser, :try_others => false)
    assert_equal 'RSS::Parser', feed.parser
    assert_equal 'Jeff Hecht', feed.entries.last.author
  end

  def test_dublin_core_creator_simple_rss
    feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rdf10], :force_parser => SimpleRssParser, :try_others => false)
    assert_equal 'SimpleRSS', feed.parser
    assert_equal 'Jeff Hecht', feed.entries.last.author
  end

  def test_entry_categories_ruby_rss
    feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20], :force_parser => RubyRssParser, :try_others => false)
    assert_equal [['Click'],['Technology'],[]], feed.items.collect {|i|i.categories}
  end

  def test_entry_categories_simple_rss
    feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20], :force_parser => SimpleRssParser, :try_others => false)
    assert_equal [['Click'],['Technology'],[]], feed.items.collect {|i|i.categories}
  end

  def test_loose_categories_ruby_rss
    feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20], :force_parser => RubyRssParser, :try_others => false, :loose => true)
    assert_equal [1,2,0], feed.entries.collect{|e|e.categories.size}
  end

  def test_loose_categories_simple_rss
    feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20], :force_parser => SimpleRssParser, :try_others => false, :loose => true)
    assert_equal [1,1,0], feed.entries.collect{|e|e.categories.size}
  end

  def test_content_encoded_simple_rss
    feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20], :force_parser => SimpleRssParser, :try_others => false)

    feed.entries.each_with_index do |e, i|
      assert_match(/test#{i+1}/, e.content)
    end
  end

  def test_content_encoded_ruby_rss
    feed = FeedNormalizer::FeedNormalizer.parse(XML_FILES[:rss20], :force_parser => RubyRssParser, :try_others => false)

    feed.entries.each_with_index do |e, i|
      assert_match(/test#{i+1}/, e.content)
    end
  end

end

