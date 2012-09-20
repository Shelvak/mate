require 'test_helper'

class WorkplaceInteractionsTest < ActionDispatch::IntegrationTest
  setup do
    @workplace = Fabricate(:workplace)
  end

  test 'should create workplace' do
    login

    visit workplaces_path

    assert_page_has_no_errors!
    assert_equal workplaces_path, current_path

    click_link I18n.t('view.workplaces.new')

    assert_page_has_no_errors!
    assert_equal new_workplace_path, current_path

    assert page.has_css?('.form-inputs')

    within '.form-inputs' do
      fill_in Workplace.human_attribute_name('address'), with: 'San Martin'
      fill_in Workplace.human_attribute_name('city'), with: 'Godoy Cruz'
      fill_in Workplace.human_attribute_name('state'), with: 'Mendoza'
      select 'Chile', from: 'workplace_country'
      fill_in Workplace.human_attribute_name('client_id'), with: 1
    end

    assert_difference 'Workplace.count' do
      click_button I18n.t(
        'helpers.submit.create',model: Workplace.model_name.human
      )
    end

    workplace = Workplace.reorder('id DESC').first
    assert_page_has_no_errors!
    assert_equal workplace_path(workplace), current_path
  end

  test 'should delete workplace' do
    login

    visit workplaces_path

    assert_page_has_no_errors!
    assert_equal workplaces_path, current_path
    assert page.has_css?('table tbody')

    within 'table tbody' do
      assert_difference 'Workplace.count', -1 do
        assert_difference 'Version.count' do
          remove_data_confirm_attr
          find('a[data-method="delete"]').click
        end
      end
    end

    assert_page_has_no_errors!
    assert_equal workplaces_path, current_path
    assert page.has_css?('.alert', text: I18n.t(
      'view.workplaces.correctly_deleted'
    ))
  end

  test 'should modifier a workplace' do
    login

    visit edit_workplace_path(@workplace)

    assert_page_has_no_errors!
    assert_equal edit_workplace_path(@workplace), current_path
    assert page.has_css?('.form-inputs')

    within '.form-inputs' do
      fill_in Workplace.human_attribute_name('address'), with: '25 de Mayo'
    end

    assert_no_difference 'Workplace.count' do
      assert_difference 'Version.count' do
        click_button I18n.t(
          'helpers.submit.update', model: Workplace.model_name.human
        )
      end
    end

    assert_page_has_no_errors!
    assert_equal workplace_path(@workplace), current_path
  end
end
