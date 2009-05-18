require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  context 'GET to index' do
    setup do
      @user = Factory.build(:user)
      @users = [@user]
      User.stubs(:all).returns(@users)

      @recurring_events = [Factory.build(:recurring_event, :id => 1)]
      Event.stub_chain(:next, :recurring).returns(@recurring_events)

      @special_events = [Factory.build(:special_event, :id => 2)]
      Event.stub_chain(:next, :special).returns(@special_events)

      @recent_jobs = [Factory.build(:job, :id => 3)]
      Job.stubs(:recent).returns(@recent_jobs)

      get :index
    end

    should_respond_with :success
    should_render_template :index

    should "fetch users" do
      assert_received(User, :all)
    end

    should "fetch 4 recurring events" do
      assert_received(Event, :next) {|expect| expect.with(4) }
      assert_received(Event, :recurring)
    end

    should "fetch 5 special events" do
      assert_received(Event, :next) {|expect| expect.with(5) }
      assert_received(Event, :special)
    end

    should "fetch jobs" do
      assert_received(Job, :recent)
    end

    should_assign_to(:users) { @users }
    should_assign_to(:recurring_events) { @recurring_events }
    should_assign_to(:special_events) { @special_events }
    should_assign_to(:recent_jobs) { @recent_jobs }
  end

  context "given a future recurring event on GET to index" do
    setup do
      @event = Factory(:recurring_event, :date => 2.days.from_now)
      get :index
    end

    should "link to event" do
      assert_select "a[href=?]", event_path(@event), :text => @event.title
    end
  end

  context "given a future special event on GET to index" do
    setup do
      @event = Factory(:special_event, :date => 2.days.from_now)
      get :index
    end

    should "link to event" do
      assert_select "#other_events .center" do
        assert_select "a[href=?]", event_path(@event), :text => @event.title
      end
    end
  end
end

