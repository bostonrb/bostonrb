require File.dirname(__FILE__) + '/../test_helper'

class PagesControllerTest < ActionController::TestCase

  %w(sponsors).each do |page|
    context "on GET to /pages/#{page}" do
      setup { get :show, :id => page }

      should_respond_with :success
      should_render_template page
    end
  end

  context "on GET to /pages/invalid" do
    setup { get :show, :id => "invalid" }
    should_respond_with :missing
  end

  context "on GET to /pages" do
    setup { get :index }
    should_respond_with :missing
  end

end
