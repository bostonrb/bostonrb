require 'test_helper'

class EventsHelperTest < ActionView::TestCase
  context "event_links" do
    setup do
      @event = stub('event', :title => 'some title')
      self.stubs(:link_to)

      event_links [@event]
    end

    should "link to each" do
      assert_received(self, :link_to) {|expect| expect.with(@event.title, event_path(@event))}
    end
  end
end
