require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  context 'GET to index' do
    setup { get :index }

    should_respond_with :success
    should_render_template :index
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

