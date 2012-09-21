require 'test_helper'

class PlacesControllerTest < ActionController::TestCase

  setup do
    @place = Fabricate(:place)
    @user = Fabricate(:user)
  end

  test "should get index" do
    sign_in @user

    get :index
    assert_response :success
    assert_not_nil assigns(:places)
    assert_select '#unexpected_error', false
    assert_template "places/index"
  end

  test "should get new" do
    sign_in @user

    get :new
    assert_response :success
    assert_not_nil assigns(:place)
    assert_select '#unexpected_error', false
    assert_template "places/new"
  end

  test "should create place" do
    sign_in @user

    assert_difference('Place.count') do
      post :create, place: Fabricate.attributes_for(:place)
    end

    assert_redirected_to place_url(assigns(:place))
  end

  test "should show place" do
    sign_in @user

    get :show, id: @place
    assert_response :success
    assert_not_nil assigns(:place)
    assert_select '#unexpected_error', false
    assert_template "places/show"
  end

  test "should get edit" do
    sign_in @user

    get :edit, id: @place
    assert_response :success
    assert_not_nil assigns(:place)
    assert_select '#unexpected_error', false
    assert_template "places/edit"
  end

  test "should update place" do
    sign_in @user

    put :update, id: @place, 
      place: Fabricate.attributes_for(:place, name: 'Updated')
    assert_redirected_to place_url(assigns(:place))
  end

  test "should destroy place" do
    sign_in @user

    assert_difference('Place.count', -1) do
      delete :destroy, id: @place
    end

    assert_redirected_to places_path
  end
end
