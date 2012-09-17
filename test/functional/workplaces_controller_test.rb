require 'test_helper'

class WorkplacesControllerTest < ActionController::TestCase
  setup do
    @workplace = Fabricate(:workplace)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workplaces)
    assert_select '#unexpected_error', false
    assert_template 'workplaces/index'
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:workplace)
    assert_select '#unexpected_error', false
    assert_template 'workplaces/new'
  end

  test "should create workplace" do
    assert_difference('Workplace.count') do
      post :create, workplace: Fabricate.attributes_for(:workplace)
    end

    assert_redirected_to workplace_url(assigns(:workplace))
  end

  test "should show workplace" do
    get :show, id: @workplace
    assert_response :success
    assert_not_nil assigns(:workplace)
    assert_select '#unexpected_error', false
    assert_template 'workplaces/show'    
  end

  test "should get edit" do
    get :edit, id: @workplace
    assert_response :success
    assert_not_nil assigns(:workplace)
    assert_select '#unexpected_error', false
    assert_template 'workplaces/edit'
  end

  test "should update workplace" do
    put :update, id: @workplace, workplace: Fabricate.attributes_for(
      :workplace, address: 'Upd'
    )
    assert_redirected_to workplace_url(assigns(:workplace))
    assert_equal 'Upd', @workplace.reload.address
  end

  test "should destroy workplace" do
    assert_difference('Workplace.count', -1) do
      delete :destroy, id: @workplace
    end

    assert_redirected_to workplaces_url
  end
end
