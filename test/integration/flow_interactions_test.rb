require 'test_helper'

class FlowInteracionsTets < ActionDispatch::IntegrationTest
  setup do
    @flow = Fabricate(:flow)
  end
          
  test 'should create flow' do
    login

    visit flows_path

    assert_page_has_no_errors!
    assert_equal flows_path, current_path

    click_link I18n.t('view.flows.new')

    assert_page_has_no_errors!
    assert_equal new_flow_path, current_path

    assert page.has_css?('.form-inputs')

    within '.form-inputs' do
      fill_in 'flow_detail', with: 'Some'
      select I18n.t('view.flows.in'), from: 'flow_in'
      fill_in 'flow_charged_at', with: I18n.l(Time.zone.today)
      fill_in 'flow_code', with: 123
      fill_in 'flow_subcode', with: 'XYZ'
      fill_in 'flow_receipt', with: 12
      fill_in 'flow_register', with: 123123
      fill_in 'flow_total_amount', with: 123.0
    end

    assert_difference 'Flow.count' do
      click_button I18n.t(
        'helpers.submit.create', model: Flow.model_name.human
      )
    end

    flow = Flow.order('id DESC').first
    assert_page_has_no_errors!
    assert_equal flow_path(flow), current_path
  end

  test 'should delete flow' do
    login

    visit flows_path

    assert_page_has_no_errors!
    assert_equal flows_path, current_path
    assert page.has_css?('table tbody')

    within 'table tbody' do
      assert_difference 'Flow.count', -1 do
        assert_difference 'Version.count' do
          remove_data_confirm_attr
          find('a[data-method="delete"]').click
        end
      end
    end

    assert_page_has_no_errors!
    assert_equal flows_path, current_path
    assert page.has_css?(
      '.alert', text: I18n.t('view.flows.correctly_deleted')
    )
  end

  test 'should edit a flow' do
    login

    visit edit_flow_path(@flow)

    assert_page_has_no_errors!
    assert_equal edit_flow_path(@flow), current_path
    assert page.has_css?('.form-inputs')

    within '.form-inputs' do
      fill_in 'flow_code', with: 1
    end

    assert_no_difference 'Flow.count' do
      assert_difference 'Version.count' do
        click_button I18n.t(
          'helpers.submit.update', model: Flow.model_name.human
        )
      end
    end
  end
end
