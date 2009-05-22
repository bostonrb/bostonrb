Factory.define :entry do |factory|
  factory.sequence(:url) {|n| "http://example.com/posts-#{n}" }
  factory.content "so let me tell you about this world we live in..."
  factory.title "hello world"
  factory.association(:feed)
  factory.sequence(:checksum) {|n| Digest::MD5.hexdigest(n.to_s)}
end
