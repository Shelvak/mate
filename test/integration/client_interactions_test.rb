require 'test_helper'

class ClientInteractionsTest < ActionDispatch::IntegrationTest
  setup do
    @client = Fabricate(:client)
  end

  test 'should create client' do
    login

    visit clients_path

    assert_page_has_no_errors!
    assert_equal clients_path, current_path

    click_link I18n.t('helpers.submit.new', model: Client.model_name.human)

    assert_page_has_no_errors!
    assert_equal new_client_path, current_path

    assert page.has_css?('.form-inputs')

    within '.form-inputs' do
      fill_in Client.human_attribute_name('name'), with: 'Nation'
      fill_in Client.human_attribute_name('ident'), with: 'nation-the-only-one'
      fill_in Client.human_attribute_name('email'), with: 'nation@thebest.com'
      fill_in Client.human_attribute_name('phone'), with: '5-3322-678'
      fill_in Client.human_attribute_name('website'), with: 'nation.com'
    end

    assert_difference 'Client.count' do
      click_button I18n.t(
        'helpers.submit.create', model: Client.model_name.human
      )
    end

    client = Client.reorder('id DESC').first
    assert_page_has_no_errors!
    assert_equal client_path(client), current_path
  end
  
  test 'should delete client' do
    login

    visit clients_path

    assert_page_has_no_errors!
    assert_equal clients_path, current_path
    assert page.has_css?('table tbody')

    within 'table tbody' do
      assert_difference 'Client.count', -1 do
        assert_difference 'Version.count' do
          remove_data_confirm_attr
          find('a[data-method="delete"]').click
        end
      end
    end

    assert_page_has_no_errors!
    assert_equal clients_path, current_path
    assert page.has_css?(
      '.alert', text: I18n.t('view.clients.correctly_deleted')
    )
  end

  test 'should modifier a client' do
    login

    visit edit_client_path(@client)

    assert_page_has_no_errors!
    assert_equal edit_client_path(@client), current_path
    assert page.has_css?('.form-inputs')
  
    within '.form-inputs' do
      fill_in Client.human_attribute_name('name'), with: 'The best client'
    end

    assert_no_difference 'Client.count' do
      assert_difference 'Version.count' do
        click_button I18n.t(
          'helpers.submit.update', model: Client.model_name.human
        )
      end
    end
  end

  test 'should get filtered clients' do
    login
    
    i = 0
    3.times { Fabricate(:client, name: "filtered #{i += 1}") }

    visit clients_path

    assert_page_has_no_errors!
    assert_equal clients_path, current_path

    assert page.has_css?('#q')

    fill_in 'q', with: 'filtered'
    find('#q').native.send_keys :enter

    assert_page_has_no_errors!
    assert page.has_css?('table tbody')

    assert page.has_css?('table tbody tr', text: 'filtered', count: 3)
  end
end
