require File.dirname(__FILE__) + '/../test_helper'

class JobsControllerTest < ActionController::TestCase

  context 'on GET to /jobs when signed in' do
    setup do
      sign_in
      get :index
    end
    
    should_assign_to :jobs
    should_render_template :index
    should_respond_with :success
  end

  context 'on GET to /jobs/new when signed in' do
    setup do
      sign_in
      get :new
    end

    should "recognize route" do
      assert_recognizes({ :controller => 'jobs', :action => 'new' },
                          :path => '/jobs/new', :method => :get)
    end

    should_assign_to       :job
    should_render_template :new
    should_respond_with    :success

    should 'have new_event form' do
      assert_select 'form[id=new_job]' do
        should_have_job_form_fields
      end
    end
  end

  context 'A POST to /jobs when signed in' do
    setup do
      sign_in
      @old_count = Job.count
      post :create, :job => Factory.attributes_for(:job)
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'jobs', :action => 'create' },
                          :path       => '/jobs', :method => :post)
    end

    should 'create a job' do
      assert_equal @old_count + 1, Job.count
    end

    should_redirect_to("home") { root_path }
  end

  context "on GET to /jobs :format => 'atom' with jobs" do
    setup do
      Factory(:job)
      get :index, :format => 'atom'
    end

    should_assign_to       :jobs
    should_render_template 'index.atom'
    should_respond_with    :success
  end

  context "on GET to /jobs :format => 'atom' without jobs" do
    setup do
      get :index, :format => 'atom'
    end

    should_assign_to       :jobs
    should_render_template 'index.atom'
    should_respond_with    :success
  end
  
  context 'on PUT to /jobs/:id when signed in' do
    setup do
      sign_in
      @job = Factory(:job)
      put :update, :id => @job.to_param, :job => { :title => 'Updated Rails Developer' }
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'jobs', :action => 'update', :id => @job.to_param },
                          :path       => "/jobs/#{@job.to_param}", :method => :put)
    end

    should 'update job' do
      assert @job.title != Job.find_by_id(@job.id).title
    end

    should_redirect_to("job page") { job_path(@job) }
  end

  context 'A GET to /jobs/:id without editing privileges' do
    setup do
      @job = Factory :job
      UserSession.any_instance.stubs(:edit_job?).returns(false)
      get :show, :id => @job.id
    end

    should_respond_with :success
    should_render_template :show

    should 'not show Edit link' do
      assert_select "a[href=?]", edit_job_path(@job), false
    end
  end

  context 'A GET to /jobs/:id with editing privileges' do
    setup do
      @job = Factory :job
      UserSession.any_instance.stubs(:edit_job?).returns(true)
      get :show, :id => @job.id
    end

    should_respond_with :success
    should_render_template :show

    should 'show Edit link' do
      assert_select "a[href=?]", edit_job_path(@job), "Edit"
    end
  end

  context 'A GET to /jobs/:id/edit when signed in' do
    setup do
      sign_in
      @job = Factory(:job)
      UserSession.any_instance.expects(:edit_job?).returns(true)
      get :edit, :id => @job.id
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'jobs', :action => 'edit', :id => @job.to_param },
                          :path       => "/jobs/#{@job.id}/edit", :method => :get)
    end

    should_respond_with :success
    should_render_template :edit

    should 'have a form to create a new Job' do
      assert_select "form[id=edit_job_#{@job.to_param}][action=/jobs/#{@job.to_param}]" do
        should_have_job_form_fields
      end
    end
  end

  context 'A GET to /jobs/:id/edit without edit privileges when signed in' do
    setup do
      sign_in
      @job = Factory(:job)
      UserSession.any_instance.expects(:edit_job?).returns(false)
      get :edit, :id => @job.id
    end

    should_set_the_flash_to 'Editing time expired.'
    should_redirect_to("home") { root_path }
  end

  context 'A DELETE to /jobs/:id when signed in' do
    setup do
      sign_in
      @job   = Factory(:job)
      @old_count = Job.count
      delete :destroy, :id => @job.id
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'jobs', :action => 'destroy', :id => @job.to_param },
                          :path => "/jobs/#{@job.to_param}", :method => :delete)
    end

    should 'destroy job' do
      assert_equal @old_count-1, Job.count
    end

    should 'show flash notice' do
      assert_match /deleted/i, flash[:notice]
    end

    should_redirect_to("home") { root_path }
  end

  protected

  def should_have_job_form_fields
    assert_select 'input[id=job_title][type=text]'
    assert_select 'input[id=job_location][type=text]'
    assert_select 'input[id=job_organization][type=text]'
    assert_select 'input[id=job_email][type=text]'
    assert_select 'textarea[id=job_description]'
    assert_select 'input[id=job_submit][type=submit]'
  end

end
