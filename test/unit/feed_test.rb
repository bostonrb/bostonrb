require 'test_helper'

class FeedTest < ActiveSupport::TestCase
  should "include Feedra::Feed" do
    assert Feed.included_modules.include?(Feedra::Feed)
  end

  should_belong_to :feed_owner
end

