Factory.define :feed do |factory|
  factory.sequence(:feed_url) {|n| "http://example.com/#{n}.rss"}
end
