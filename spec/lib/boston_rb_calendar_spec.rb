require_relative '../spec_helper'

describe "Boston RB Calendar Configuration" do
  it "should initilize with a reasonable test account" do
    BostonRbCalendar.auth_parameters[:username].should == "test.boston.rb@gmail.com"
    BostonRbCalendar.auth_parameters[:password].should == "ibetthisisapassword"
    BostonRbCalendar.calendar.should == "test.boston.rb%40gmail.com"
  end
  
  it "should let you shoot yourself in the foot with dumb auth settings" do
    #pull in the real settings so we can reset.
    smart_authentication = BostonRbCalendar.auth_parameters
    
    dumb_authentication = {
      :username => 'lololololol@hotmail.com',
      :password => 'somethingsilly'
    }
    BostonRbCalendar.auth_parameters = dumb_authentication
    
    BostonRbCalendar.auth_parameters.should == dumb_authentication
    
    #both upcoming and next event should send back nil
    BostonRbCalendar.next_event.should be_nil
    BostonRbCalendar.upcoming_events.should be_nil
    
    #reset for future tests
    BostonRbCalendar.auth_parameters = smart_authentication
  end
end



describe "Boston RB Calendar Upcoming Events" do

  before(:all) do 
    @upcoming_events = BostonRbCalendar.upcoming_events
  end

  
  it "should pull in at least one upcoming event" do    
    @upcoming_events.should have_at_least(1).things
  end
  
  it "should have an array of events" do
    @upcoming_events.should be_a_kind_of Array
  end
  
  it "should have an array of GCal4Ruby::Events" do
    @upcoming_events.each do |event|
      event.should be_an_instance_of GCal4Ruby::Event
    end
  end
  
  it "should only have events for the present/future" do
    @upcoming_events.each do |event|
      event.start_time.day.should >= Time.now.day
    end
  end
  
  it "should order events from earliest to latest" do
    prev_time = @upcoming_events.first.start_time
    @upcoming_events.each do |event|
      event.start_time.should be >= prev_time
      prev_time = event.start_time
    end
  end
end

describe "Boston RB Calendar Next Event" do
  before(:all) do 
    @upcoming_events = BostonRbCalendar.upcoming_events
    @next_event = BostonRbCalendar.next_event
  end
  
  it "should be the first and earliest event" do
    #we tested the order in the previous section!
    
    #The two calls will pull in different instances of the same event
    #So we need to check instance variable equality.
    attr_array = %w(title start_time end_time where)
    attr_array.each do |attr|
      @next_event.method("#{attr}").to_s.should == @upcoming_events.first.method("#{attr}").to_s
    end
  end
end