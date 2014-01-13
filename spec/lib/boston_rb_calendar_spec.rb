require 'spec_helper'

describe "Boston RB Calendar Next Event" do
  use_vcr_cassette "boston_rb_calendar"

  before do
    @next_event = BostonRbCalendar.next_event
  end

  it { @next_event.should respond_to(:title) }
  it { @next_event.should respond_to(:start_time) }
  it { @next_event.should respond_to(:end_time) }
  it { @next_event.should respond_to(:location) }

  it { @next_event.should be_an_instance_of BostonRbCalendar::CalendarEvent }

  it "should only have events for the present/future" do
    (@next_event.start_time.year + (@next_event.start_time.month/12) + (@next_event.start_time.day/365)).should >= (DateTime.current.year + (DateTime.current.month/12) + (DateTime.current.day/365))
  end

  it "should gracefully handle a network timeout" do
    BostonRbCalendar.define_singleton_method(:get_calendar_response) { sleep(10) }
    BostonRbCalendar.upcoming_events.should be_empty
    BostonRbCalendar.singleton_class.send(:remove_method, :get_calendar_response)
    BostonRbCalendar.upcoming_events.should_not be_empty
  end
end
