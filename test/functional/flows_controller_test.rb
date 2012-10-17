require 'test_helper'

class FlowsControllerTest < ActionController::TestCase

  setup do
    @flow = Fabricate(:flow)
    @user = Fabricate(:user)
  end

  test "should get index" do
    sign_in @user

    get :index
    assert_response :success
    assert_not_nil assigns(:flows)
    assert_select '#unexpected_error', false
    assert_template "flows/index"
  end

  test "should get new" do
    sign_in @user

    get :new
    assert_response :success
    assert_not_nil assigns(:flow)
    assert_select '#unexpected_error', false
    assert_template "flows/new"
  end

  test "should create flow" do
    sign_in @user

    assert_difference('Flow.count') do
      post :create, flow: Fabricate.attributes_for(:flow)
    end

    assert_redirected_to flow_url(assigns(:flow))
  end

  test "should show flow" do
    sign_in @user

    get :show, id: @flow
    assert_response :success
    assert_not_nil assigns(:flow)
    assert_select '#unexpected_error', false
    assert_template "flows/show"
  end

  test "should get edit" do
    sign_in @user

    get :edit, id: @flow
    assert_response :success
    assert_not_nil assigns(:flow)
    assert_select '#unexpected_error', false
    assert_template "flows/edit"
  end

  test "should update flow" do
    sign_in @user

    put :update, id: @flow, 
      flow: Fabricate.attributes_for(:flow, detail: 'Updated')
    assert_redirected_to flow_url(assigns(:flow))
  end

  test "should destroy flow" do
    sign_in @user

    assert_difference('Flow.count', -1) do
      delete :destroy, id: @flow
    end

    assert_redirected_to flows_path
  end
end
