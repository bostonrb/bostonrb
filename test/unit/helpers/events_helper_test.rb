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

  context "given some special events" do
    setup do
      @event = stub('event', :title => 'some title')
      Event.stubs(:next_five_special).returns([@event])
      self.stubs(:link_to)
    end

    context "the next five special event links" do
      setup { @events_links = next_five_special_event_links }

      should "find next five special events" do
        assert_received(Event, :next_five_special)
      end

      should "link to each" do
        assert_received(self, :link_to) {|expect| expect.with('some title', event_path(@event))}
      end
    end
  end
end
