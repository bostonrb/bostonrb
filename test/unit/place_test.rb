require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  should_validate_presence_of :name, :address, :description
  should_have_many :events
end
