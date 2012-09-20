require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase
  setup do
    @transaction = Fabricate(:transaction)
    @user = Fabricate(:user)

    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transactions)
    assert_select '#unexpected_error', false
    assert_template 'transactions/index'
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:transaction)
    assert_select '#unexpected_error', false
    assert_template 'transactions/new'
  end

  test "should create transaction" do
    assert_difference 'Transaction.count' do
      post :create, transaction: Fabricate.attributes_for(:transaction)
    end

    assert_redirected_to transaction_url(assigns(:transaction))
  end

  test "should show transaction" do
    get :show, id: @transaction
    assert_response :success
    assert_not_nil assigns(:transaction)
    assert_select '#unexpected_error', false
    assert_template 'transactions/show'
  end

  test "should get edit" do
    get :edit, id: @transaction
    assert_response :success
    assert_not_nil assigns(:transaction)
    assert_select '#unexpected_error', false
    assert_template 'transactions/edit'
  end

  test "should update transaction" do
    assert_no_difference 'Transaction.count' do
      put :update, id: @transaction, transaction: Fabricate.attributes_for(:transaction, amount: 100.50)
    end
    assert_redirected_to transaction_url(assigns(:transaction))
    assert_equal 100.50, @transaction.reload.amount
  end

  test "should destroy transaction" do
    assert_difference 'Transaction.count', -1 do
      delete :destroy, id: @transaction
    end

    assert_redirected_to transactions_url
  end
end
