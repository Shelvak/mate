require 'test_helper'

class MovementsControllerTest < ActionController::TestCase
  setup do
    @movement = Fabricate(:movement)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movements)
    assert_select '#unexpected_error', false
    assert_template 'movements/index'
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:movement)
    assert_select '#unexpected_error', false
    assert_template 'movements/new'
  end

  test "should create movement" do
    assert_difference 'Movement.count' do
      post :create, movement: Fabricate.attributes_for(:movement)
    end

    assert_redirected_to movement_url(assigns(:movement))
  end

  test "should show movement" do
    get :show, id: @movement
    assert_response :success
    assert_not_nil assigns(:movement)
    assert_select '#unexpected_error', false
    assert_template 'movements/show'
  end

  test "should get edit" do
    get :edit, id: @movement
    assert_response :success
    assert_not_nil assigns(:movement)
    assert_select '#unexpected_error', false
    assert_template 'movements/edit'
  end

  test "should update movement" do
    assert_no_difference 'Movement.count' do
      put :update, id: @movement, movement: Fabricate.attributes_for(:movement, amount: 3.23)
    end

    assert_redirected_to movement_url(assigns(:movement))
    assert_equal 3.23, @movement.reload.amount

  end

  test "should destroy movement" do
    assert_difference 'Movement.count', -1 do
      delete :destroy, id: @movement
    end

    assert_redirected_to movements_url
  end

  test 'should get autocomplete bank list' do
    bank = Fabricate(:bank)
    get :autocomplete_for_bank_name, format: :json, q: bank.name
    assert_response :success
        
    banks = ActiveSupport::JSON.decode(@response.body)

    assert_equal 1, banks.size
    assert banks.all? { |d| d['label'].match /#{bank.name}/i }
    
    get :autocomplete_for_bank_name, format: :json, q: 'pxsazt'
    assert_response :success
        
    banks = ActiveSupport::JSON.decode(@response.body)

    assert banks.empty? 
  end

  test 'should get autocomplete code list' do
    code = Fabricate(:code)
    get :autocomplete_for_code_number, format: :json, q: code.number
    assert_response :success

    codes = ActiveSupport::JSON.decode(@response.body)

    assert_equal 1, codes.size
    assert codes.all? { |d| d['label'].match /#{codes.number}/i }

    get :autocomplete_for_code_number, format: :json, q: '200'
    assert_response :success

    codes = ActiveSupport::JSON.decode(@response.body)

    assert codes.empty?
  end

  test 'should get autocomplete client list' do
    client = Fabricate(:client)
    get :autocomplete_for_client_name, format: :json, q: client.name
    assert_response :success

    clients = ActiveSupport::JSON.decode(@response.body)

    assert_equal 1, clients.size
    assert clients.all? { |d| d['label'].match /#{client.name}/i }

    get :autocomplete_for_bank_name, format: :json, q: 'ashdahsd'
    assert_response :success

    clients = ActiveSupport::JSON.decode(@response.body)

    assert clients.empty?
  end
end
