require 'test_helper'

class AdvancesControllerTest < ActionController::TestCase
  setup do
    @advance = Fabricate(:advance)
    @user = Fabricate(:user)
 
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:advances)
    assert_select '#unexpected_error', false
    assert_template 'advances/index'
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:advance)
    assert_select '#unexpected_error', false
    assert_template 'advances/new'
  end

  test "should create advance" do
    assert_difference 'Advance.count' do
      post :create, advance: Fabricate.attributes_for(:advance)
    end

    assert_redirected_to advance_url(assigns(:advance))
  end

  test "should show advance" do
    get :show, id: @advance
    assert_response :success
    assert_not_nil assigns(:advance)
    assert_select '#unexpected_error', false
    assert_template 'advances/show'
  end

  test "should get edit" do
    get :edit, id: @advance
    assert_response :success
    assert_not_nil assigns(:advance)
    assert_select '#unexpected_error', false
    assert_template 'advances/edit'
  end

  test "should update advance" do
    assert_no_difference 'Advance.count' do
      put :update, id: @advance, advance: Fabricate.attributes_for(:advance, amount: 100.50)
    end
    assert_redirected_to advance_url(assigns(:advance))
    assert_equal 100.50, @advance.reload.amount
  end

  test "should destroy advance" do
    assert_difference 'Advance.count', -1 do
      delete :destroy, id: @advance
    end

    assert_redirected_to advances_url
  end
end
