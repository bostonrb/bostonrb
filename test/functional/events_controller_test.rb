require File.dirname(__FILE__) + '/../test_helper'

class EventsControllerTest < ActionController::TestCase

  should_route :get, '/events', :controller => 'events', :action => 'index'

  context 'GET to :index' do
    setup do
      @events = paginate(Factory.stub(:event))
      Event.stubs(:paginate_by_date).returns(@events)

      get :index, :page => nil
    end

    should_assign_to       (:events) { @events }
    should_render_template :index
    should_respond_with    :success
    should 'paginate by date' do
      assert_received(Event, :paginate_by_date) {|called| called.with(nil) } 
    end
  end

  context "GET to :index :format => 'rss' with events in the future" do
    setup do
      @next = Factory(:event, :date => 2.days.from_now)
      Event.stubs(:next).returns([@next])

      get :index, :format => 'rss'
    end
    should_redirect_to("events_path :format => :atom") { events_path(:atom) }

  end

  context "GET to :index :format => 'atom' with events in the future" do
    setup do
      @next = Factory(:event, :date => 2.days.from_now)
      Event.stubs(:next).returns([@next])
      get :index, :format => 'atom'
    end

    should_assign_to       :events
    should_render_template 'index.atom'
    should_respond_with    :success
  end

  context "on GET to :index, :format => 'ics' with events in the future" do
    setup do
      @next = Factory(:event, :title => 'Fun Times', :date => 2.days.from_now, :lat => 42.351414, :lng => -71.057609, :location => 'Backchannel Media')
      Event.stubs(:next).returns([@next])
      @now = Time.now
      Time.stubs(:now).returns(@now)
      get :index, :format => 'ics'
    end
    should_assign_to(:events) { [@next] }
    should_respond_with :success
    should 'render a valid iCal object' do
      assert_nothing_raised do
        RiCal.parse_string @response.body
      end
    end
    context '(the rendered event)' do
      setup do
        cal = RiCal.parse_string(@response.body).first # RiCal parses to [Calendar]
        @event = cal.events.first
        assert @event
      end
      should 'render the title as summary' do
        assert_equal @next.title, @event.summary
      end
      should 'use PUBLIC for the visibility class' do
        assert_equal 'PUBLIC', @event.security_class
      end
      should "use the event's created_at for created" do
        assert_equal @next.created_at.utc.to_s(:rfc822), @event.created.utc.to_s(:rfc822)
      end
      should "use the event's date for dtstart" do
        assert_equal @next.date.utc.to_s(:rfc822), @event.dtstart.utc.to_s(:rfc822)
      end
      should_eventually "use the event's lat/lng for geo" do
        assert_equal "#{@next.lat};#{@next.lng}", @event.geo
      end
      should "use the event's location for location" do
        assert_equal @next.location, @event.location
      end
      should "use the event's updated_at for modified" do
        assert_equal @next.updated_at.utc.to_s(:rfc822), @event.last_modified.utc.to_s(:rfc822)
      end
      should "use now for dtstamp" do
        assert_equal @now.utc.to_s(:rfc822), @event.dtstamp.utc.to_s(:rfc822)
      end
      should "create a meaningful unique UID in email format" do
        assert_equal "event-#{@next.id}@bostonrb.org", @event.uid
      end
      should "use a link to the event for url" do
        assert_equal "http://test.host/events/#{@next.id}", @event.url
      end
      should "add 'RUBY' to the categories" do
        assert_equal ['RUBY'], @event.categories
      end
    end
  end

  should_route :get, '/events/new', :controller => 'events', :action => 'new'

  context "on GET to #new when signed out" do
    setup { get :new }
    should_deny_access
  end

  context 'on GET to :new when signed in' do
    setup do
      sign_in
      get :new
    end

    should_assign_to       :event
    should_render_template :new
    should_respond_with    :success

    should 'have new_event form' do
      assert_select 'form[id=new_event]' do
        should_have_event_form_fields
        assert_select 'input[type=submit][id=event_submit]'
      end
    end
  end

  context "on GET to #copy when signed out" do
    setup do
      @event = Factory(:event)
      get :copy, :id => @event.to_param
    end
    should_deny_access
  end

  context 'on GET to :copy when signed in' do
    setup do
      sign_in
      @event = Factory(:event)
      get :copy, :id => @event.to_param
    end

    should_assign_to       :event
    should_render_template :new
    should_respond_with    :success

    should 'have new_event form' do
      assert_select "form[id=new_event]" do
        should_have_event_form_fields
        assert_select "input[type=submit][id=event_submit]"
      end
    end
  end

  should_route :get, '/events/1',
    :controller => 'events', :action => 'show', :id => '1'

  context 'on GET to :show' do
    setup do
      @event = Factory(:event)
      stubbed_action_view do |view|
        view.stubs(:event_map)
      end
      get :show, :id => @event.to_param
    end

    should_assign_to :event
    should_respond_with :success
    should_render_template :show

    should "generate the event's map" do
      stubbed_action_view do |view|
        assert_received(view, :event_map) {|expect| expect.with(@event) }
      end
    end
  end

  should_route :post, '/events',
    :controller => 'events', :action => 'create'

  context "on POST to #create when signed out" do
    setup { post :create }
    should_deny_access
  end

  context 'on POST to :create when signed in' do
    setup do
      sign_in
      post :create,
        :event => Factory.attributes_for(:event, :title => "new event")
    end

    should_set_the_flash_to /event created/i
    should_redirect_to("home") { root_path }
    should "create Event" do
      assert Event.find_by_title("new event")
    end
  end

  should_route :get, "/events/1/edit",
    :controller => 'events', :action => 'edit', :id => '1'

  context "on GET to #edit when signed out" do
    setup { get :edit, :id => 1 }
    should_deny_access
  end

  context 'on GET to :edit when signed in' do
    setup do
      sign_in
      @event = Factory(:event)
      get :edit, :id => @event.to_param
    end

    should_assign_to       :event
    should_render_template :edit
    should_respond_with    :success

    should 'have event form' do
      assert_select "form[id=edit_event_#{@event.to_param}]" do
        should_have_event_form_fields
        assert_select 'input[type=submit][id=event_submit]'
      end
    end
  end

  should_route :put, "/events/1",
    :controller => 'events', :action => 'update', :id => '1'

  context "on PUT to #update when signed out" do
    setup { put :update, :id => 1 }
    should_deny_access
  end

  context 'a PUT to :update when signed in' do
    setup do
      sign_in
      @event = Factory(:event)
      put :update, :id => @event.to_param, :event => { :description => 'Updated Rails Developer' }
    end

    should 'update event description' do
      assert_not_equal @event.description, Event.find_by_id(@event.id).description
    end

    should_redirect_to("event page") { event_path(@event) }
  end

  context 'A PUT to :update with bad parameters when signed in' do
    setup do
      sign_in
      @event = Factory(:event)
      put :update, :id => @event.to_param, :event => { :title => '' }
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
