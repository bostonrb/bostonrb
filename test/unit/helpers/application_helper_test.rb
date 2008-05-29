require File.dirname(__FILE__) + '/../../test_helper'

class ApplicationHelperTest < HelperTestCase
  include ApplicationHelper
  
  context 'ApplicationHelper#blueprint_ie' do
    setup do
      @result = blueprint_ie
    end
    
    should 'not be nil' do
      assert_not_nil @result
    end
    
    should 'include blueprint ie css' do
      expected = %q(<link href="/blueprint/ie.css" media="screen" rel="stylesheet" type="text/css" />)
      assert @result.include?(expected)
    end

    should 'do magic ie comment to only load in IE' do
      expected = %q(<!--[if IE]>)
      assert @result.include?(expected)
    end 
  end
  
  context 'ApplicationHelper#next_event' do
    context 'when there is a next event' do
      setup do
        @event = new_event
        Event.stubs(:next).returns(@event)
        @result = next_event
      end
      
      should 'output something' do
        assert_not_nil @result
      end
      
      should 'have #next_event' do
        assert @result.include?(%q(id="next_event_banner"))
      end
      
      should 'have event type in text' do
        assert @result.include?(@event.event_type)
      end
      
      should 'have event date' do
        assert @result.include?(@event.date.to_s(:european))
      end
    end
    
    context 'when there is not a next event' do
      setup do
        Event.stubs(:next).returns(nil)
        @result = next_event
      end
      
      should "not output anything" do
        assert_nil @result
      end
    end
  end
end
