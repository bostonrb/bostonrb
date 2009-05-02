require 'test_helper'

class PlacesControllerTest < ActionController::TestCase

  context 'GET index' do
    setup do
      get :index
    end
    should_respond_with :success
    should_assign_to :places
  end

  context 'GET new' do
    setup do
      get :new
    end

    should_respond_with :success
    should_assign_to :place
  end

  context 'POST create' do
    setup do
      post :create, :place => Factory.attributes_for(:place)
      @place = Place.find(:all).last
    end

    should_redirect_to("place show") { place_path(@place) }
  end

  context 'GET show' do
    setup do
      @place = Factory(:place)
      get :show, :id => @place.id
    end
    should_respond_with :success
  end

  context 'GET edit' do
    setup do
      @place = Factory(:place)
      get :edit, :id => @place.id
    end
    should_respond_with :success
  end

  context 'PUT update' do
    setup do
      @place = Factory(:place)
      put :update, :id => @place.id, :place => {:name => 'PLACEEE!'}
    end
    should_redirect_to("place show") { place_path(@place) }
  end

  context 'DELETE destroy' do
    setup do
      @place = Factory(:place)
      delete :destroy, :id => @place.id
    end
    should_redirect_to("places index") { places_path }
  end

end
