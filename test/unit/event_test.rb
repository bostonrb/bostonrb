require 'test_helper'

class EventTest < ActiveSupport::TestCase
  should_validate_presence_of :date, :title, :location

  should_have_markup :description, :required => true, :cache_html => true

  context 'with events in the past and future' do
    setup do
      @future = Factory(:event, :date => 2.days.from_now)
      @past   = Factory(:event, :date => 2.days.ago)
    end

    context 'Event#next' do
      setup { @events = Event.next }

      should "find Events" do
        assert @events.any?
        assert @events.all? { |event| event.is_a?(Event) }
      end

      should "only find Events in the future" do
        assert @events.all? { |event| event.date > Time.now }
      end
    end
  end

  context "next without any future events" do
    setup { @next = Event.next }

    should "not find Events" do
      assert_equal [], @next
    end
  end

  context "next with future events" do
    setup do
      @event = Factory(:event, :date => 3.days.from_now)
      @next  = Event.next
    end

    should "find the event" do
      assert_equal [@event], @next
    end
  end

  context "given recurring and special events" do
    setup do
      @recurring = Event.new_hackfest
    end
  end

  context "In order to geocode, Event" do
    should_have_db_columns :lat, :lng

    context "with good location" do
      setup do
        @event = Factory(:event, :location => 'Boston, MA, 02114')
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
        @event = Factory(:event, :location => 'Non existent place')
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
