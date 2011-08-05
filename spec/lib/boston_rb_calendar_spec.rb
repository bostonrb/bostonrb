require 'spec_helper'

describe "Boston RB Calendar Configuration" do
  it "should initilize with a reasonable test account" do
    BostonRbCalendar.config.user_name.should == "test.boston.rb@gmail.com"
    BostonRbCalendar.config.password.should == "ibetthisisapassword"
    BostonRbCalendar.config.calendar.should == "test.boston.rb%40gmail.com"
  end

end
  
describe "Boston RB Calendar Next Event" do
  before(:all) do 
    @next_event = BostonRbCalendar.next_event
  end
  
  it { @next_event.should respond_to :title }
  it { @next_event.should respond_to :start_time }  
  it { @next_event.should respond_to :end_time }
  it { @next_event.should respond_to :location }  
  it { @next_event.should be_an_instance_of BostonRbCalendar::Event }
  
  it "should only have events for the present/future" do
    (@next_event.start_time.year + (@next_event.start_time.month/12) + (@next_event.start_time.day/365)).should >= (Time.now.year + (Time.now.month/12) + (Time.now.day/365))
  end 
end