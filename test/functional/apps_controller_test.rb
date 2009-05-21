require 'test_helper'

class AppsControllerTest < ActionController::TestCase

  context 'A GET to index' do
    setup do
      get :index
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'apps', :action => 'index' },
                          :path       => '/apps',        :method => :get)
    end

    should_respond_with :success
    should_assign_to :apps
    should_assign_to :left_apps
    should_assign_to :right_apps
  end

  context 'on GET to #new when signed in' do
    setup do
      sign_in
      get :new
    end

    should_assign_to :app
    should_respond_with :success
    should_render_template :new

    should 'have a form to create a new App' do
      assert_select 'form[id=new_app][action=/apps]' do
        should_have_app_form_fields
      end
    end
  end

  context 'on POST to #create when signed in' do
    setup do
      sign_in
      @old_count = App.count
      post :create, :app => Factory.attributes_for(:app)
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'apps', :action => 'create' },
                          :path       => '/apps', :method => :post)
    end

    should 'create an app' do
      assert_equal @old_count + 1, App.count
    end

    should_redirect_to("apps index") { apps_path }
  end

  context 'on GET to /apps/:id/edit when signed in' do
    setup do
      sign_in
      @app = Factory(:app)
      get :edit, :id => @app.to_param
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'apps', :action => 'edit', :id => @app.to_param },
                          :path       => "/apps/#{@app.to_param}/edit", :method => :get)
    end

    should_respond_with :success
    should_render_template :edit

    should 'have a form to create a new App' do
      assert_select "form[id=edit_app_#{@app.to_param}][action=/apps/#{@app.to_param}]" do
        should_have_app_form_fields
      end
    end
  end

  context 'on PUT to #update when signed in' do
    setup do
      sign_in
      @app = Factory(:app)
      put :update, :id => @app.to_param, :app => { :name => 'updated_recommendable' }
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'apps', :action => 'update', :id => @app.to_param },
                          :path       => "/apps/#{@app.to_param}", :method => :put)
    end

    should 'update app' do
      assert_not_equal @app.name, App.find_by_id(@app.to_param).name
    end

    should_redirect_to("apps index") { apps_path }
  end

  context 'on DELETE to #destroy when signed in' do
    setup do
      sign_in
      @app   = Factory(:app)
      @old_count = App.count
      delete :destroy, :id => @app.to_param
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'apps', :action => 'destroy', :id => @app.to_param },
                          :path => "/apps/#{@app.to_param}", :method => :delete)
    end

    should 'destroy app' do
      assert_equal @old_count - 1, App.count
    end

    should 'show flash notice' do
      assert_equal 'App was successfully deleted.', flash[:notice]
    end

    should_redirect_to("apps index") { apps_path }
  end

  protected

  def should_have_app_form_fields
    assert_select 'input[id=app_name][type=text]'
    assert_select 'input[id=app_homepage_url][type=text]'
    assert_select 'input[id=app_submit][type=submit]'
  end

end
