require 'test_helper'

class ClientsControllerTest < ActionController::TestCase

  setup do
    @client = Fabricate(:client)
    @user = Fabricate(:user)
  end

  test "should get index" do
    sign_in @user

    get :index
    assert_response :success
    assert_not_nil assigns(:clients)
    assert_select '#unexpected_error', false
    assert_template "clients/index"
  end

  test "should get new" do
    sign_in @user

    get :new
    assert_response :success
    assert_not_nil assigns(:client)
    assert_select '#unexpected_error', false
    assert_template "clients/new"
  end

  test "should create client" do
    sign_in @user

    assert_difference('Client.count') do
      post :create, client: Fabricate.attributes_for(:client)
    end

    assert_redirected_to client_url(assigns(:client))
  end

  test "should show client" do
    sign_in @user

    get :show, id: @client
    assert_response :success
    assert_not_nil assigns(:client)
    assert_select '#unexpected_error', false
    assert_template "clients/show"
  end

  test "should get edit" do
    sign_in @user

    get :edit, id: @client
    assert_response :success
    assert_not_nil assigns(:client)
    assert_select '#unexpected_error', false
    assert_template "clients/edit"
  end

  test "should update client" do
    sign_in @user

    put :update, id: @client, 
      client: Fabricate.attributes_for(:client, name: 'The best')
    assert_redirected_to client_url(assigns(:client))
  end

  test "should destroy client" do
    sign_in @user

    assert_difference('Client.count', -1) do
      delete :destroy, id: @client
    end

    assert_redirected_to clients_path
  end

  test 'should get filtered index' do
    sign_in @user
    
    Fabricate(:client, name: 'in_filtered_index')
    
    get :index, q: 'filtered_index'
    assert_response :success
    assert_not_nil assigns(:clients)
    assert_equal 1, assigns(:clients).size
    assert assigns(:clients).all? { |u| u.to_s =~ /filtered_index/ }
    assert_not_equal assigns(:clients).size, Client.count
    assert_select '#unexpected_error', false
    assert_template 'clients/index'
  end
end
