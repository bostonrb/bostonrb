require 'spec_helper'

TIME_REGEX = /[a-zA-Z]+,\s[a-zA-Z]+\s\d+(st|th|rd)<br\/>\s\d+PM\sto\s+\d+PM/
GOOGLE_MAPS_REGEX = /maps\.google\.com\/maps\?q=.*/

describe NextEventHelper do
  use_vcr_cassette "boston_rb_calendar"
  
  before do
    @event = BostonRbCalendar.next_event
  end
  describe "NextEventHelper#format_event_times" do
    it { helper.format_event_times(@event).should match(TIME_REGEX) }
  end
  
  describe "NextEventHelper#link_to_location" do
    it { helper.link_to_location(@event.location).should match(GOOGLE_MAPS_REGEX) }
  end
end