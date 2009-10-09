require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

  context 'A GET to index' do
    setup do
      get :index
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'projects', :action => 'index' },
                          :path       => '/projects',        :method => :get)
    end

    should_respond_with :success
    should_assign_to :projects
  end

  context 'on GET to :show' do
    setup do
      @event = Factory(:project)
      get :show, :id => @event.to_param
    end

    should_assign_to       :project
    should_render_template :show
    should_respond_with    :success
  end

end
