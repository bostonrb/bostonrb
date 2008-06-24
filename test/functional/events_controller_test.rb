require File.dirname(__FILE__) + '/../test_helper'

class EventsControllerTest < ActionController::TestCase
  
  context 'GET to :index with no events' do
    setup do
      Event.stubs(:upcoming).returns([])
      Event.stubs(:next).returns(nil)
      get :index
    end
  
    should_assign_to :upcoming_events
    should_not_assign_to :next_event
    should_respond_with :success
    should_render_template :index
  end
  
  context 'GET to :index with one future event' do
    setup do
      @next = Factory(:event, :date => 2.days.from_now)
      Event.stubs(:upcoming).returns([])
      Event.stubs(:next).returns(@next)
      get :index
    end
  
    should_respond_with :success
    should_render_template :index
    should_assign_to :upcoming_events
    should_assign_to :next_event
    
    should "show next event description" do
      assert_select '#next_event' do
        # assert_select '.event_description'
        assert_select '#map'
      end
    end
  end
  
  context "GET to :index with one future event, no upcoming events" do
    setup do
      @next = Factory(:event, :date => 2.days.from_now)
      get :index
    end

    should "set next event" do
      assert_equal assigns(:next_event), @next
    end

    should "not include next event in upcoming events" do
      assert !assigns(:upcoming_events).include?(@next)
    end
  end
   
  context 'on GET to :new' do
    setup do
      get :new
    end
    
    should_assign_to :event
    should_respond_with :success
    should_render_template :new
    
    should 'have new_event form' do
      assert_select 'form[id=new_event]' do
        should_have_event_form_fields
        assert_select 'input[type=submit][id=event_submit]'
      end
    end
  end
  
  context 'on GET to :show' do
    setup do
      @event = Factory(:event)
      get :show, :id => @event.to_param
    end
    
    should 'recognize route' do
      assert_recognizes({ :controller => 'events', :action => 'show', :id => @event.to_param},
                          :path => "/events/#{@event.to_param}", :method => :get)
    end
    
    should_assign_to :event
    should_respond_with :success
    should_render_template :show
  end
  
  context 'A POST to :create' do
    setup do
      @old_count = Event.count
      post :create, :event => Factory.attributes_for(:event)
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'events', :action => 'create' },
                          :path       => '/events', :method => :post)
    end

    should 'create a job' do
      assert_equal @old_count + 1, Event.count
    end

    should_redirect_to 'events_path'
  end
  
  context 'A PUT to :update' do
    setup do
      @event = Factory(:event)
      put :update, :id => @event.to_param, :event => { :description => 'Updated Rails Developer' }
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'events', :action => 'update', :id => @event.to_param },
                          :path       => "/events/#{@event.id}", :method => :put)
    end

    should 'update event description' do
      assert_not_equal @event.description, Event.find_by_id(@event.id).description
    end

    should_redirect_to 'events_path'
  end
  
  context 'A PUT to :update with bad parameters' do
    setup do
      @event = Factory(:event)
      put :update, :id => @event.to_param, :event => { :title => '' }
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'events', :action => 'update', :id => @event.to_param },
                          :path       => "/events/#{@event.to_param}", :method => :put)
    end

    should 'not update event description' do
      assert_equal @event.description, Event.find_by_id(@event.id).description
    end
    
    should_assign_to :event
    should_respond_with :success
    should_render_template :edit
    
    should 'have update event form' do
      assert_select "form[id=edit_event_#{@event.to_param}]" do
        should_have_event_form_fields
        assert_select 'input[type=submit][id=event_submit]'
      end
    end
  end
  
  protected
  
    def should_have_event_form_fields()
      assert_select 'input[id=event_title][type=text]'
      assert_select 'input[id=event_location][type=text]'
      assert_select 'textarea[id=event_description]'
    end
  
end
