require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  should_route :get, '/events/new', :controller => 'events', :action => 'new'

  context "on GET to #new when signed out" do
    setup { get :new }
    should_deny_access
  end

  context "on GET to #new when signed in" do
    setup do
      sign_in
      get :new
    end

    should_assign_to       :company
    should_render_template :new
    should_respond_with    :success
  end
end

