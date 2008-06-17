require File.dirname(__FILE__) + '/../test_helper'

class PlacesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:places)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_place
    assert_difference('Place.count') do
      post :create, :place => { }
    end

    assert_redirected_to place_path(assigns(:place))
  end

  def test_should_show_place
    get :show, :id => places(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => places(:one).id
    assert_response :success
  end

  def test_should_update_place
    put :update, :id => places(:one).id, :place => { }
    assert_redirected_to place_path(assigns(:place))
  end

  def test_should_destroy_place
    assert_difference('Place.count', -1) do
      delete :destroy, :id => places(:one).id
    end

    assert_redirected_to places_path
  end
end
