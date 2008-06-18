require File.dirname(__FILE__) + '/../test_helper'

class PlaceTest < ActiveSupport::TestCase
  should_require_attributes :name, :address, :description
  should_have_many :events
end
