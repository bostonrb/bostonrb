require 'test_helper'

class EventsHelperTest < ActionView::TestCase
  context "the next four recurring events" do
    setup { @events = next_four_recurring_events }

    should "be the next four recurring events" do
      expected = Event.next(4).recurring
      assert_equal expected, @events
    end
  end
end
