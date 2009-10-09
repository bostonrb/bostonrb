require 'test_helper'

class PresentationsControllerTest < ActionController::TestCase

  should_route :post, '/presentations',
    :controller => 'presentations', :action => 'create'

  should_route :put, '/presentations/1',
    :controller => 'presentations', :action => 'update', :id => '1'

  should_route :delete, '/presentations/1',
    :controller => 'presentations', :action => 'destroy', :id => '1'

  should_route :get, '/presentations/new',
    :controller => 'presentations', :action => 'new'
    
  should_route :get, '/presentations',
    :controller => 'presentations', :action => 'index'
    
  context 'on GET to /presentations when signed in' do
    setup do
      sign_in
      get :index
    end

    should_assign_to :presentations
    should_render_template :index
    should_respond_with :success
  end


  context 'on GET to new when signed in' do
    setup do
      sign_in
      get :new
    end

    should_assign_to       :presentation
    should_render_template :new
    should_respond_with    :success

    should 'have a form to create a new Presentation' do
      assert_select 'form[id=new_presentation][action=/presentations]' do
        should_have_presentation_form_fields
      end
    end
  end

  context 'on POST to #create when signed in' do
    setup do
      sign_in
      @old_count = Presentation.count
      post :create, :presentation => Factory.attributes_for(:presentation)
    end

    should 'create a presentation' do
      assert_equal @old_count + 1, Presentation.count
    end

    should_redirect_to("home page") { root_path }
  end

  should_route :get, '/presentations/1/edit',
    :controller => 'presentations', :action => 'edit', :id => '1'

  context 'on GET to #edit when signed in' do
    setup do
      sign_in
      @presentation = Factory(:presentation)
      get :edit, :id => @presentation.to_param
    end

    should_assign_to       :presentation
    should_render_template :edit
    should_respond_with    :success

    should 'have a form to create a new Presentation' do
      assert_select "form[id=edit_presentation_#{@presentation.to_param}][action=/presentations/#{@presentation.to_param}]" do
        should_have_presentation_form_fields
      end
    end
  end

  context 'on PUT to /presentations/:id when signed in' do
    setup do
      sign_in
      @presentation = Factory(:presentation)
      put :update, :id => @presentation.id, :presentation => { :title => 'updated_recommendable' }
    end

    should 'update presentation' do
      assert_not_equal @presentation.title, Presentation.find_by_id(@presentation.id).title
    end

    should_redirect_to("presentation page") { presentation_path(@presentation) }
  end

  context 'on DELETE to /presentations/:id when signed in' do
    setup do
      sign_in
      @presentation = Factory(:presentation)
      @old_count    = Presentation.count
      delete :destroy, :id => @presentation.id
    end

    should 'destroy presentation' do
      assert_equal @old_count - 1, Presentation.count
    end

    should_set_the_flash_to /deleted/
    should_redirect_to("home page") { root_path }
  end

  protected

  def should_have_presentation_form_fields
    assert_select 'input[id=presentation_title][type=text]'
    assert_select 'input[id=presentation_url][type=text]'
    assert_select 'input[id=presentation_submit][type=submit]'
  end

end
