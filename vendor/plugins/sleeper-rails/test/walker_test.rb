require 'test_helper'
require 'scaler'

class WalkerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "messing around with walker" do
	@w = Scaler::Walker.new('http://google.com')
	assert_not_nil @w
#	@w.walk!
  end
end