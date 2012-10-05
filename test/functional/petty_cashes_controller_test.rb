require 'test_helper'

class PettyCashesControllerTest < ActionController::TestCase
  setup do
    @petty_cash = Fabricate(:petty_cash)
    @user = Fabricate(:user)
 
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:petty_cashes)
    assert_select '#unexpected_error', false
    assert_template 'petty_cashes/index'
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:petty_cash)
    assert_select '#unexpected_error', false
    assert_template 'petty_cashes/new'
  end

  test "should create petty_cash" do
    assert_difference 'PettyCash.count' do
      post :create, petty_cash: Fabricate.attributes_for(:petty_cash)
    end

    assert_redirected_to petty_cash_url(assigns(:petty_cash))
  end

  test "should show petty_cash" do
    get :show, id: @petty_cash
    assert_response :success
    assert_not_nil assigns(:petty_cash)
    assert_select '#unexpected_error', false
    assert_template 'petty_cashes/show'
  end

  test "should get edit" do
    get :edit, id: @petty_cash
    assert_response :success
    assert_not_nil assigns(:petty_cash)
    assert_select '#unexpected_error', false
    assert_template 'petty_cashes/edit'
  end

  test "should update petty_cash" do
    assert_no_difference 'PettyCash.count' do
      put :update, id: @petty_cash,
      petty_cash: Fabricate.attributes_for(:petty_cash, amount: 100.50)
    end

    assert_redirected_to petty_cash_url(assigns(:petty_cash))
    assert_equal 100.50, @petty_cash.reload.amount
  end

  test "should destroy petty_cash" do
    assert_difference 'PettyCash.count', -1 do
      delete :destroy, id: @petty_cash
    end

    assert_redirected_to petty_cashes_url
  end
end
