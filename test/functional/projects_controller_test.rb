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
    should_assign_to :left_projects
    should_assign_to :right_projects
  end

  context 'on GET to #new when signed in' do
    setup do
      sign_in
      get :new
    end

    should_assign_to :project
    should_respond_with :success
    should_render_template :new

    should 'have a form to create a new Project' do
      assert_select 'form[id=new_project][action=/projects]' do
        should_have_project_form_fields
      end
    end
  end

  context 'on POST to #create when signed in' do
    setup do
      sign_in
      @old_count = Project.count
      post :create, :project => Factory.attributes_for(:project)
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'projects', :action => 'create' },
                          :path       => '/projects', :method => :post)
    end

    should 'create a project' do
      assert_equal @old_count + 1, Project.count
    end

    should_redirect_to("home") { root_path }
  end

  context 'on GET to /projects/:id/edit when signed in' do
    setup do
      sign_in
      @project = Factory(:project)
      get :edit, :id => @project.to_param
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'projects', :action => 'edit', :id => @project.to_param },
                          :path       => "/projects/#{@project.to_param}/edit", :method => :get)
    end

    should_respond_with :success
    should_render_template :edit

    should 'have a form to create a new Project' do
      assert_select "form[id=edit_project_#{@project.to_param}][action=/projects/#{@project.to_param}]" do
        should_have_project_form_fields
      end
    end
  end

  context 'on PUT to #update when signed in' do
    setup do
      sign_in
      @project = Factory(:project)
      put :update, :id => @project.to_param, :project => { :name => 'updated_recommendable' }
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'projects', :action => 'update', :id => @project.to_param },
                          :path       => "/projects/#{@project.to_param}", :method => :put)
    end

    should 'update project' do
      assert_not_equal @project.name, Project.find_by_id(@project.to_param).name
    end

    should_redirect_to("project page") { project_path(@project) }
  end

  context 'on DELETE to #destroy when signed in' do
    setup do
      sign_in
      @project   = Factory(:project)
      @old_count = Project.count
      delete :destroy, :id => @project.to_param
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'projects', :action => 'destroy', :id => @project.to_param },
                          :path => "/projects/#{@project.to_param}", :method => :delete)
    end

    should 'destroy project' do
      assert_equal @old_count - 1, Project.count
    end

    should 'show flash notice' do
      assert_equal 'Project deleted.', flash[:notice]
    end

    should_redirect_to("home") { root_path }
  end

  protected

  def should_have_project_form_fields
    assert_select 'input[id=project_name][type=text]'
    assert_select 'input[id=project_homepage_url][type=text]'
    assert_select 'textarea[id=project_description]'
    assert_select 'input[id=project_submit][type=submit]'
  end

end
