require 'test_helper'

class BankInteractionsTest < ActionDispatch::IntegrationTest
  setup do
    @bank = Fabricate(:bank)
  end

  test 'should create bank' do
    login

    visit banks_path

    assert_page_has_no_errors!
    assert_equal banks_path, current_path

    click_link I18n.t('helpers.submit.new', model: Bank.model_name.human)

    assert_page_has_no_errors!
    assert_equal new_bank_path, current_path

    assert page.has_css?('.form-inputs')

    within '.form-inputs' do
      fill_in Bank.human_attribute_name('name'), with: 'Nation'
      fill_in Bank.human_attribute_name('website'), with: 'nation.com'
      fill_in Bank.human_attribute_name('amount'), with: 32157.32
    end

    assert_difference 'Bank.count' do
      click_button I18n.t('helpers.submit.create', model: Bank.model_name.human)
    end

    bank = Bank.reorder('id DESC').first
    assert_page_has_no_errors!
    assert_equal bank_path(bank), current_path
  end
  
  test 'should delete bank' do
    login

    visit banks_path

    assert_page_has_no_errors!
    assert_equal banks_path, current_path
    assert page.has_css?('table tbody')

    within 'table tbody' do
      assert_difference 'Bank.count', -1 do
        assert_difference 'Version.count' do
          remove_data_confirm_attr
          find('a[data-method="delete"]').click
        end
      end
    end

    assert_page_has_no_errors!
    assert_equal banks_path, current_path
    assert page.has_css?('.alert', text: I18n.t('view.banks.correctly_deleted'))
  end

  test 'should modifier a bank' do
    login

    visit edit_bank_path(@bank)

    assert_page_has_no_errors!
    assert_equal edit_bank_path(@bank), current_path
    assert page.has_css?('.form-inputs')
  
    within '.form-inputs' do
      fill_in Bank.human_attribute_name('name'), with: 'The best corrupt bank'
    end

    assert_no_difference 'Bank.count' do
      assert_difference 'Version.count' do
        click_button I18n.t(
          'helpers.submit.update', model: Bank.model_name.human
        )
      end
    end
  end
end
