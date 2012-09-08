require 'test_helper'

class MovementsControllerTest < ActionController::TestCase
  setup do
    @movement = Fabricate(:movement)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movements)
    assert_select '#unexpected_error', false
    assert_template 'movements/index'
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:movement)
    assert_select '#unexpected_error', false
    assert_template 'movements/new'
  end

  test "should create movement" do
    assert_difference 'Movement.count' do
      post :create, movement: Fabricate.attributes_for(:movement)
    end

    assert_redirected_to movement_url(assigns(:movement))
  end

  test "should show movement" do
    get :show, id: @movement
    assert_response :success
    assert_not_nil assigns(:movement)
    assert_select '#unexpected_error', false
    assert_template 'movements/show'
  end

  test "should get edit" do
    get :edit, id: @movement
    assert_response :success
    assert_not_nil assigns(:movement)
    assert_select '#unexpected_error', false
    assert_template 'movements/edit'
  end

  test "should update movement" do
    assert_no_difference 'Movement.count' do
      put :update, id: @movement, movement: Fabricate.attributes_for(:movement, amount: 3.23)
    end

    assert_redirected_to movement_url(assigns(:movement))
    assert_equal 3.23, @movement.reload.amount

  end

  test "should destroy movement" do
    assert_difference 'Movement.count', -1 do
      delete :destroy, id: @movement
    end

    assert_redirected_to movements_url
  end
end
