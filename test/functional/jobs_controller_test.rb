require File.dirname(__FILE__) + '/../test_helper'

class JobsControllerTest < ActionController::TestCase
  
  %w(html rss).each do |format|
    context "A GET to index #{format}" do
      setup do
        Factory(:job)
        get :index, :format => format
      end

      should "recognize route" do
        assert_recognizes({ :controller => 'jobs', :action => 'index' },
                            :path => '/jobs', :method => :get)
      end
      
      should_respond_with :success
      should_assign_to :jobs
      should_assign_to :old_job_count
    end
  end

  context 'on GET to :new' do
    setup do
      get :new
    end
    
    should "recognize route" do
      assert_recognizes({ :controller => 'jobs', :action => 'new' },
                          :path => '/jobs/new', :method => :get)
    end
    
    should_assign_to :job
    should_respond_with :success
    should_render_template :new
    
    should 'have new_event form' do
      assert_select 'form[id=new_job]' do
        should_have_job_form_fields
      end
    end
  end
  
  context 'A GET to /jobs/old' do
    setup do
      get :old
    end
    should_respond_with :success
    should_assign_to :jobs
    should_assign_to :recent_job_count
    should_render_template :index
  end

  context 'A POST to /jobs' do
    setup do
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

    should_redirect_to 'jobs_url'
  end

  context 'A GET to /jobs/:id/edit' do
    setup do
      @job = Factory(:job)
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

  context 'A PUT to /jobs/:id' do
    setup do
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

    should_redirect_to 'jobs_path'
  end

  context 'A DELETE to /jobs/:id' do
    setup do
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
      assert flash[:notice] == 'Job was successfully deleted.'
    end

    should_redirect_to 'jobs_url'
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
