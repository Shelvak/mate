require 'test_helper'

class ChargesControllerTest < ActionController::TestCase
  setup do
    @charge = Fabricate(:charge)
    @user = Fabricate(:user)
 
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:charges)
    assert_select '#unexpected_error', false
    assert_template 'charges/index'
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:charge)
    assert_select '#unexpected_error', false
    assert_template 'charges/new'
  end

  test "should create charge" do
    assert_difference 'Charge.count' do
      post :create, charge: Fabricate.attributes_for(:charge)
    end

    assert_redirected_to charge_url(assigns(:charge))
  end

  test "should show charge" do
    get :show, id: @charge
    assert_response :success
    assert_not_nil assigns(:charge)
    assert_select '#unexpected_error', false
    assert_template 'charges/show'
  end

  test "should get edit" do
    get :edit, id: @charge
    assert_response :success
    assert_not_nil assigns(:charge)
    assert_select '#unexpected_error', false
    assert_template 'charges/edit'
  end

  test "should update charge" do
    assert_no_difference 'Charge.count' do
      put :update, id: @charge,
      charge: Fabricate.attributes_for(:charge, amount: 100.50)
    end

    assert_redirected_to charge_url(assigns(:charge))
    assert_equal 100.50, @charge.reload.amount
  end

  test "should destroy charge" do
    assert_difference 'Charge.count', -1 do
      delete :destroy, id: @charge
    end

    assert_redirected_to charges_url
  end
end
