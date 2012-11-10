require 'test_helper'

class BankInteractionsTest < ActionDispatch::IntegrationTest
  setup do
    @bank = Fabricate(:bank)
    Fabricate(:bank_account, bank_id: @bank.id)
    Fabricate(:bank_account, bank_id: @bank.id)
  end



  test 'should create bank' do
    login

    # Entrar a bancos
    visit banks_path
    assert_page_has_no_errors!
    assert_equal banks_path, current_path

    # Nuevo banco
    click_link I18n.t('helpers.submit.new', model: Bank.model_name.human)
    assert_page_has_no_errors!
    assert_equal new_bank_path, current_path

    # Formulario
    assert page.has_css?('.form-inputs')
    within '.form-inputs' do
      fill_in Bank.human_attribute_name('name'), with: 'Nacion'
      fill_in Bank.human_attribute_name('website'), with: 'nacion.com'
      fill_in Bank.human_attribute_name('phone'), with: '4123456'
      fill_in Bank.human_attribute_name('address'), with: 'Calle 1234'
      fill_in Bank.human_attribute_name('contact_name'), with: 'Pedro Ortega'
    end

    # Verificar que no haya campos de cuenta bancaria preexistentes
    assert page.has_no_css?('.remove_nested_fields')

    # Agregar campos para dos cuentas en el formulario y verificar
    assert page.has_css?('a', :text => I18n.t('view.banks.add_account'))
    click_link I18n.t('view.banks.add_account')
    click_link I18n.t('view.banks.add_account')
    accounts = all('.fields', visible: true)
    assert_equal accounts.count, 2
 
    # Caja de ahorros en dólares
    within accounts[0] do
      number = find('input[name$="[number]"]')
      office_number = find('input[name$="[office_number]"]')
      kind = find('select[name$="[kind]"]')
      currency = find('select[name$="[currency]"]')
      amount = find('input[name$="[amount]"]')

      fill_in number[:id], with: 'CA123456'
      fill_in office_number[:id], with: '17'
      select I18n.t('view.banks.account_kinds.savings_account'), from: kind[:id]
      select I18n.t('view.banks.money_kinds.dollar'), from: currency[:id]
      fill_in amount[:id], with: '10000'
    end

    # Cuenta Corriente en pesos
    within accounts[1] do
      number = find('input[name$="[number]"]')
      office_number = find('input[name$="[office_number]"]')
      kind = find('select[name$="[kind]"]')
      currency = find('select[name$="[currency]"]')
      amount = find('input[name$="[amount]"]')

      fill_in number[:id], with: 'CC123456'
      fill_in office_number[:id], with: '17'
      select I18n.t('view.banks.account_kinds.checking_account'), from: kind[:id]
      select I18n.t('view.banks.money_kinds.local'), from: currency[:id]
      fill_in amount[:id], with: '1500'
    end

    # Guardar
    assert_difference 'Bank.count', 1 do
      assert_difference 'BankAccount.count', 2 do
        click_button I18n.t('helpers.submit.create', model: Bank.model_name.human)
      end
    end

    # Ver
    bank = Bank.reorder('id DESC').first
    assert_page_has_no_errors!
    assert_equal bank_path(bank), current_path
  end



  test 'should delete bank' do
    login

    # Entrar a bancos
    visit banks_path
    assert_page_has_no_errors!
    assert_equal banks_path, current_path

    # Borrar
    assert page.has_css?('table tbody')
    within 'table tbody' do
      remove_data_confirm_attr
      assert_difference 'Bank.count', -1 do
        assert_difference 'BankAccount.count', -2 do
          assert_difference 'Version.count', 3 do
            find('a[data-method="delete"]').click
          end
        end
      end
    end

    # Verificar
    assert_page_has_no_errors!
    assert_equal banks_path, current_path
    assert page.has_css?('.alert', text: I18n.t('view.banks.correctly_deleted'))
  end



  test 'should modify a bank' do
    login

    # Entrar a editar banco
    visit edit_bank_path(@bank)
    assert_page_has_no_errors!
    assert_equal edit_bank_path(@bank), current_path

    # Formulario
    assert page.has_css?('.form-inputs')
    within '.form-inputs' do
      fill_in Bank.human_attribute_name('name'), with: 'The most corrupt bank ever!!'
      fill_in Bank.human_attribute_name('address'), with: 'Paraiso fiscal'
    end

    accounts = all('.fields', visible: true)

    # Borrar la última cuenta
    assert accounts.count > 0
    accounts.last.find('.remove_nested_fields').click
    remaining = all('.fields', visible: true)
    assert_equal remaining.count, accounts.count - 1

    # Modificar primer cuenta
    within accounts.first do
      amount = find('input[name$="[amount]"]')
      fill_in amount[:id], with: '15300'
    end

    debugger

    # Guardar
    assert_no_difference 'Bank.count' do
      assert_difference 'BankAccount.count', -1 do
        assert_difference 'Version.count', 3 do
          click_button I18n.t(
            'helpers.submit.update', model: Bank.model_name.human
          )
        end
      end
    end
  end

end
