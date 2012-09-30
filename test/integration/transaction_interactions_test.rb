require 'test_helper'

class TransactionInteracionsTets < ActionDispatch::IntegrationTest
  setup do
    @transaction = Fabricate(:transaction)
  end
          
  test 'should create transaction' do
    login

    visit transactions_path

    assert_page_has_no_errors!
    assert_equal transactions_path, current_path

    click_link I18n.t('view.transactions.new')

    assert_page_has_no_errors!
    assert_equal new_transaction_path, current_path

    assert page.has_css?('.form-inputs')
    
    card = Fabricate(:card)

    within '.form-inputs' do
      fill_in Transaction.human_attribute_name('charged_at'),
        with: I18n.l(Time.zone.today)
      fill_in Transaction.human_attribute_name('amount'), with: 35687.95
      fill_in Transaction.human_attribute_name('batch'), with: 15
      fill_in Transaction.human_attribute_name('expiration'),
        with: I18n.l(Time.zone.today)
      fill_in Transaction.human_attribute_name('place_id'), with: 21
      fill_in 'transaction_auto_card_name', with: card.name
      select_first_autocomplete_item('#transaction_auto_card_name')
    end

    assert_difference 'Transaction.count' do
      click_button I18n.t(
        'helpers.submit.create', model: Transaction.model_name.human
      )
    end

    transaction = Transaction.order('id DESC').first
    assert_page_has_no_errors!
    assert_equal transaction_path(transaction), current_path
  end

  test 'should delete transaction' do
    login

    visit transactions_path

    assert_page_has_no_errors!
    assert_equal transactions_path, current_path
    assert page.has_css?('table tbody')

    within 'table tbody' do
      assert_difference 'Transaction.count', -1 do
        assert_difference 'Version.count' do
          remove_data_confirm_attr
          find('a[data-method="delete"]').click
        end
      end
    end

    assert_page_has_no_errors!
    assert_equal transactions_path, current_path
    assert page.has_css?(
      '.alert', text: I18n.t('view.transactions.correctly_deleted')
    )
  end

  test 'should edit a transaction' do
    login

    visit edit_transaction_path(@transaction)

    assert_page_has_no_errors!
    assert_equal edit_transaction_path(@transaction), current_path
    assert page.has_css?('.form-inputs')

    within '.form-inputs' do
      fill_in Transaction.human_attribute_name('batch'), with: 16
    end

    assert_no_difference 'Transaction.count' do
      assert_difference 'Version.count' do
        click_button I18n.t(
          'helpers.submit.update', model: Transaction.model_name.human
        )
      end
    end
  end
end
