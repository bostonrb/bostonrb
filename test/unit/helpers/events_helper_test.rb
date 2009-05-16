require 'test_helper'

class EventsHelperTest < ActionView::TestCase
  context "given four recurring events" do
    setup do
      4.times { Factory(:recurring_event, :date => 2.days.from_now) }
    end

    context "the next four recurring events" do
      setup { @events = next_four_recurring_events }

      should "be the next four recurring events" do
        expected = Event.find(:all, :limit => 4)
        assert_equal expected, @events
      end
    end
  end
end
