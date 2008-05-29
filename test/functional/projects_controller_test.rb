require File.dirname(__FILE__) + '/../test_helper'

class ProjectsControllerTest < ActionController::TestCase
  
  context 'A GET to index' do
    setup do
      get :index
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'projects', :action => 'index' },
                          :path       => '/',        :method => :get)
    end
    
    should_respond_with :success
    should_assign_to :projects
    should_assign_to :left_projects
    should_assign_to :right_projects
  end

  context 'on GET to :new' do
    setup do
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

  context 'A POST to /projects' do
    setup do
      @old_count = Project.count
      post :create, :project => new_project.attributes
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'projects', :action => 'create' },
                          :path       => '/projects', :method => :post)
    end

    should 'create a project' do
      assert_equal @old_count + 1, Project.count
    end

    should_redirect_to 'home_path'
  end

  context 'A GET to /projects/:id/edit' do
    setup do
      @project = create_project
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

  context 'A PUT to /projects/:id' do
    setup do
      @project = create_project
      put :update, :id => @project.to_param, :project => { :name => 'updated_recommendable' }
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'projects', :action => 'update', :id => @project.to_param },
                          :path       => "/projects/#{@project.to_param}", :method => :put)
    end

    should 'update project' do
      assert_not_equal @project.name, Project.find_by_id(@project.to_param).name
    end

    should_redirect_to 'projects_url'
  end

  context 'A DELETE to /projects/:id' do
    setup do
      @project   = create_project
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
      assert_equal 'Project was successfully deleted.', flash[:notice]
    end

    should_redirect_to 'home_path'
  end

  protected
  
    def should_have_project_form_fields
      assert_select 'input[id=project_name][type=text]'
      assert_select 'input[id=project_homepage_url][type=text]'
      assert_select 'input[id=project_feed_url][type=text]'
      assert_select 'textarea[id=project_description]'
      assert_select 'input[id=project_submit][type=submit]'
    end

end
