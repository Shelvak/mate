require 'test_helper'

class CardsControllerTest < ActionController::TestCase
  setup do
    @card = Fabricate(:card)
    @user = Fabricate(:user)

    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cards)
    assert_select '#unexpected_error', false
    assert_template 'cards/index'
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:card)
    assert_select '#unexpected_error', false
    assert_template 'cards/new'
  end

  test "should show card" do
    get :show, id: @card
    assert_response :success
    assert_not_nil assigns(:card)
    assert_select '#unexpected_error', false
    assert_template 'cards/show'
  end

  test "should get edit" do
    get :edit, id: @card
    assert_response :success
    assert_not_nil assigns(:card)
    assert_select '#unexpected_error', false
    assert_template 'cards/edit'
  end

  test "should create card" do
    assert_difference('Card.count') do
      post :create, card: Fabricate.attributes_for(:card)
    end

    assert_redirected_to card_url(assigns(:card))
  end

  test "should update card" do
    assert_no_difference 'Card.count' do
      put :update, id: @card, 
        card: Fabricate.attributes_for(:card, name: 'Visa')
    end

    assert_redirected_to card_url(assigns(:card))
    assert_equal 'Visa', @card.reload.name
  end

  test "should destroy card" do
    assert_difference('Card.count', -1) do
      delete :destroy, id: @card
    end

    assert_redirected_to cards_url
  end
end
