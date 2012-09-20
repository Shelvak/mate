require 'test_helper'

class CardsInteractionsTest < ActionDispatch::IntegrationTest
  setup do
    @card = Fabricate(:card)
    login
  end

  test 'should create card' do

    visit cards_path

    assert_page_has_no_errors!
    assert_equal cards_path, current_path

    click_link I18n.t('view.cards.new')

    assert_page_has_no_errors!
    assert_equal new_card_path, current_path

    assert page.has_css?('.form-inputs')

    within '.form-inputs' do
      fill_in Card.human_attribute_name(:name), with: 'Visa'
      fill_in Card.human_attribute_name(:address), with: 'San Martin'
      fill_in Card.human_attribute_name(:website), with: 'visa.com'
    end

    assert_difference 'Card.count' do
      click_button I18n.t('helpers.submit.create', model: Card.model_name.human)
    end

    card = Card.reorder('id DESC').first
    assert_page_has_no_errors!
    assert_equal card_path(card), current_path
  end

  test 'should delete card' do

    visit cards_path

    assert_page_has_no_errors!
    assert_equal cards_path, current_path
    assert page.has_css?('table tbody')

    within 'table tbody' do
      assert_difference 'Card.count', -1 do
        assert_difference 'Version.count' do
          remove_data_confirm_attr
          find('a[data-method="delete"]').click
        end 
      end
    end

    assert_page_has_no_errors!
    assert_equal cards_path, current_path
    assert page.has_css?('.alert', text: I18n.t('view.cards.correctly_deleted'))
  end

  test 'should modify a card' do

    visit edit_card_path(@card)

    assert_page_has_no_errors!
    assert_equal edit_card_path(@card), current_path
    assert page.has_css?('.form-inputs')

    within '.form-inputs' do
      fill_in Card.human_attribute_name('name'), with: 'Fucking Card'
    end

    assert_no_difference 'Card.count' do
      assert_difference 'Version.count' do
        click_button I18n.t(
          'helpers.submit.update', model: Card.model_name.human
        )
      end
    end

    assert_page_has_no_errors!
    assert_equal card_path(@card), current_path
  end
end
