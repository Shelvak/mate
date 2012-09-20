require 'test_helper'

class BanksControllerTest < ActionController::TestCase
  setup do
    @bank = Fabricate(:bank)
    @user = Fabricate(:user)
  end

  test 'should get index' do
    sign_in @user
    
    get :index
    assert_response :success
    assert_not_nil assigns(:banks)
    assert_select '#unexpected_error', false
    assert_template 'banks/index'
  end
  
  test 'should get new' do
    sign_in @user
    
    get :new
    assert_response :success
    assert_not_nil assigns(:bank)
    assert_select '#unexpected_error', false
    assert_template 'banks/new'
  end
  
  test 'should get edit' do
    sign_in @user

    get :edit, id: @bank
    assert_response :success
    assert_not_nil assigns(:bank)
    assert_select '#unexpected_error', false
    assert_template 'banks/edit'
  end

  test 'should show bank' do
    sign_in @user

    get :show, id: @bank
    assert_response :success
    assert_not_nil assigns(:bank)
    assert_select '#unexpected_error', false
    assert_template 'banks/show'
  end

  test 'should create bank' do
    sign_in @user
    
    assert_difference('Bank.count') do
      post :create, bank: Fabricate.attributes_for(:bank)
    end

    assert_redirected_to bank_url(assigns(:bank))
  end
  
  test 'should update bank' do
    sign_in @user

    assert_no_difference 'Bank.count' do
      put :update, id: @bank,
        bank: Fabricate.attributes_for(:bank, name: 'Upd')
    end

    assert_redirected_to bank_url(assigns(:bank))
    assert_equal 'Upd', @bank.reload.name
  end

   test 'should destroy bank' do
    sign_in @user

    assert_difference('Bank.count', -1) do
      delete :destroy, id: @bank
    end

    assert_redirected_to banks_url
  end

  test 'should get filtered list' do
    sign_in @user

    Fabricate(:bank, name: 'in_filtered_index')
   
    get :index, q: 'filtered_index'
    assert_response :success
    assert_not_nil assigns(:banks)
    assert_equal 1, assigns(:banks).size
    assert assigns(:banks).all? { |u| u.to_s =~ /filtered_index/ }
    assert_not_equal assigns(:banks).size, Bank.count
    assert_select '#unexpected_error', false
    assert_template 'banks/index'
  end 
end

