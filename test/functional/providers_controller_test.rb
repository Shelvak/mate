require 'test_helper'

class ProvidersControllerTest < ActionController::TestCase

  setup do
    @provider = Fabricate(:provider)
    @user = Fabricate(:user)
  end

  test "should get index" do
    sign_in @user

    get :index
    assert_response :success
    assert_not_nil assigns(:providers)
    assert_select '#unexpected_error', false
    assert_template "providers/index"
  end

  test "should get new" do
    sign_in @user

    get :new
    assert_response :success
    assert_not_nil assigns(:provider)
    assert_select '#unexpected_error', false
    assert_template "providers/new"
  end

  test "should create provider" do
    sign_in @user

    assert_difference('Provider.count') do
      post :create, provider: Fabricate.attributes_for(:provider)
    end

    assert_redirected_to provider_url(assigns(:provider))
  end

  test "should show provider" do
    sign_in @user

    get :show, id: @provider
    assert_response :success
    assert_not_nil assigns(:provider)
    assert_select '#unexpected_error', false
    assert_template "providers/show"
  end

  test "should get edit" do
    sign_in @user

    get :edit, id: @provider
    assert_response :success
    assert_not_nil assigns(:provider)
    assert_select '#unexpected_error', false
    assert_template "providers/edit"
  end

  test "should update provider" do
    sign_in @user

    put :update, id: @provider, 
      provider: Fabricate.attributes_for(:provider, name: 'The best')
    assert_redirected_to provider_url(assigns(:provider))
  end

  test "should destroy provider" do
    sign_in @user

    assert_difference('Provider.count', -1) do
      delete :destroy, id: @provider
    end

    assert_redirected_to providers_path
  end

  test 'should get filtered index' do
    sign_in @user
    
    Fabricate(:provider, name: 'in_filtered_index')
    
    get :index, q: 'filtered_index'
    assert_response :success
    assert_not_nil assigns(:providers)
    assert_equal 1, assigns(:providers).size
    assert assigns(:providers).all? { |u| u.to_s =~ /filtered_index/ }
    assert_not_equal assigns(:providers).size, Provider.count
    assert_select '#unexpected_error', false
    assert_template 'providers/index'
  end
end
