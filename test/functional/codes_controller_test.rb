require 'test_helper'

class CodesControllerTest < ActionController::TestCase
  setup do
    @code = Fabricate(:code)
    @user = Fabricate(:user)

    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:codes)
    assert_select '#unexpected_error', false
    assert_template 'codes/index'
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:code)
    assert_select '#unexpected_error', false
    assert_template 'codes/new'
  end

  test "should create code" do
    assert_difference 'Code.count' do
      post :create, code: Fabricate.attributes_for(:code)
    end

    assert_redirected_to code_url(assigns(:code))
  end

  test "should show code" do
    get :show, id: @code
    assert_response :success
    assert_not_nil assigns(:code)
    assert_select '#unexpected_error', false
    assert_template 'codes/show'
  end

  test "should get edit" do
    get :edit, id: @code
    assert_response :success
    assert_not_nil assigns(:code)
    assert_select '#unexpected_error', false
    assert_template 'codes/edit'
  end

  test "should update code" do
    assert_no_difference 'Code.count' do
      put :update, id: @code,
      code: Fabricate.attributes_for(:code, detail: 'Something Wrong?')
    end

    assert_redirected_to code_url(assigns(:code))
    assert_equal 'Something Wrong?', @code.reload.detail
  end

  test "should destroy code" do
    assert_difference 'Code.count', -1 do
      delete :destroy, id: @code
    end

    assert_redirected_to codes_url
  end
end
