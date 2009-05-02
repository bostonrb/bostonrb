require 'test_helper'

class VideosControllerTest < ActionController::TestCase

  context 'A GET to index' do
    setup do
      get :index
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'videos', :action => 'index' },
                          :path       => '/videos',        :method => :get)
    end
    
    should_respond_with :success
    should_assign_to :videos
  end

  context 'on GET to :new' do
    setup do
      get :new
    end
    
    should_assign_to :video
    should_respond_with :success
    should_render_template :new
    
    should 'have a form to create a new Video' do
      assert_select 'form[id=new_video][action=/videos]' do
        should_have_video_form_fields
      end
    end
  end

  context 'A POST to /videos' do
    setup do
      @old_count = Video.count
      post :create, :video => Factory.attributes_for(:video)
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'videos', :action => 'create' },
                          :path       => '/videos', :method => :post)
    end

    should 'create a video' do
      assert_equal @old_count + 1, Video.count
    end

    should_redirect_to("videos index") { videos_path }
  end

  context 'A GET to /videos/:id/edit' do
    setup do
      @video = Factory(:video)
      get :edit, :id => @video.to_param
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'videos', :action => 'edit', :id => @video.to_param },
                          :path       => "/videos/#{@video.to_param}/edit", :method => :get)
    end

    should_respond_with :success
    should_render_template :edit
    
    should 'have a form to create a new Video' do
      assert_select "form[id=edit_video_#{@video.to_param}][action=/videos/#{@video.to_param}]" do
        should_have_video_form_fields
      end
    end
  end

  context 'A PUT to /videos/:id' do
    setup do
      @video = Factory(:video)
      put :update, :id => @video.id, :video => { :title => 'updated_recommendable' }
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'videos', :action => 'update', :id => @video.to_param },
                          :path       => "/videos/#{@video.id}", :method => :put)
    end

    should 'update video' do
      assert_not_equal @video.title, Video.find_by_id(@video.id).title
    end

    should_redirect_to("videos index") { videos_path }
  end

  context 'A DELETE to /videos/:id' do
    setup do
      @video   = Factory(:video)
      @old_count = Video.count
      delete :destroy, :id => @video.id
    end

    should 'recognize route' do
      assert_recognizes({ :controller => 'videos', :action => 'destroy', :id => @video.to_param },
                          :path => "/videos/#{@video.to_param}", :method => :delete)
    end

    should 'destroy video' do
      assert_equal @old_count - 1, Video.count
    end

    should 'show flash notice' do
      assert_equal 'Video was successfully deleted.', flash[:notice]
    end

    should_redirect_to("videos index") { videos_path }
  end

  protected

  def should_have_video_form_fields
    assert_select 'input[id=video_title][type=text]'
    assert_select 'input[id=video_url][type=text]'
    assert_select 'input[id=video_submit][type=submit]'
  end

end
