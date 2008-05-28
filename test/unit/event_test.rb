require File.dirname(__FILE__) + '/../test_helper'

class EventTest < ActiveSupport::TestCase
  
  should_require_attributes :date, :event_type, :description

  context "upcoming" do
    setup do
      @future = create_event(:date => 2.days.from_now)
      @past   = create_event(:date => 2.days.ago)
      @events = Event.upcoming
    end

    should "find Events" do
      assert @events.any?
      assert @events.all? { |event| event.is_a?(Event) }
    end
    
    should "only find Events in the future" do
      assert @events.all? { |event| event.date > Time.now }
    end
  end

  context "hackfests" do
    setup do
      @hackfest = create_hackfest_event(:event_type => 'Hackfest')
      @kata     = create_event(:event_type => 'Kata')
      @events   = Event.hackfest
    end

    should "find Events" do
      assert @events.any?
      assert @events.all? { |event| event.is_a?(Event) }
    end
    
    should "only find hackfests" do
      assert @events.all? { |event| event.event_type == 'Hackfest' }
    end
  end
  
  context "meetings" do
    setup do
      @meeting = create_event(:event_type => 'Meeting')
      @kata    = create_event(:event_type => 'Kata')
      @events  = Event.meeting
    end

    should "find Events" do
      assert @events.any?
      assert @events.all? { |event| event.is_a?(Event) }
    end
    
    should "only find meetings" do
      assert @events.all? { |event| event.event_type == 'Meeting' }
    end
  end
  
  context "katas" do
    setup do
      @kata     = create_event(:event_type => 'Kata')
      @hackfest = create_event(:event_type => 'Hackfest')
      @events   = Event.kata
    end

    should "find Events" do
      assert @events.any?
      assert @events.all? { |event| event.is_a?(Event) }
    end
    
    should "only find katas" do
      assert @events.all? { |event| event.event_type == 'Kata' }
    end
  end
  
  context "next without any future events" do
    setup do
      @next = Event.next
    end

    should "not find Events" do
      assert_nil @next
    end
  end
  
  context "In order to geocode, Event" do
    should_have_db_columns :lat, :lng
    
    context "with good location" do
      setup do
        @event = create_event(:location => 'Boston, MA, 02114')
        GeoKit::Geocoders::MultiGeocoder.expects(:geocode).returns(GeoKit::GeoLoc.new)
        GeoKit::GeoLoc.any_instance.expects(:success).returns(true)
        GeoKit::GeoLoc.any_instance.expects(:lat).returns(42.356004)
        GeoKit::GeoLoc.any_instance.expects(:lng).returns(-71.061619)
        @event.save
      end

      should "set lat after save" do
        assert_not_nil @event.lat
      end

      should "set lng after save" do
        assert_not_nil @event.lng
      end
      
      should "have lat_lng_pair" do
        assert @event.lat_lng_pair.any?
        assert @event.lat_lng_pair.all? { |x| x.is_a? Float }
      end
      
      should "be geocoded" do
        assert @event.geocoded?
      end
    end
    
    context "with bad address" do
      setup do
        @event = create_event(:location => 'Non existent place')
        GeoKit::Geocoders::MultiGeocoder.expects(:geocode).returns(GeoKit::GeoLoc.new)
        GeoKit::GeoLoc.any_instance.expects(:success).returns(false)
        @event.save
      end

      should "not raise an error" do
        assert @event.errors.empty?
      end
      
      should "not be geocoded" do
        assert !@event.geocoded?
      end
      
      should "fail silently" do
        assert @event.lat.nil?
        assert @event.lng.nil?
      end
    end
  end
  
end
