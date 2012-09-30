require 'test_helper'

class MovementInteractionsTest < ActionDispatch::IntegrationTest
  setup do
    @movement = Fabricate(:movement)
  end

  test 'should create movement' do
    login

    visit movements_path

    assert_page_has_no_errors!
    assert_equal movements_path, current_path

    click_link I18n.t('helpers.submit.new', model: Movement.model_name.human)

    assert_page_has_no_errors!
    assert_equal new_movement_path, current_path

    assert page.has_css?('.form-inputs')
  
    code = Fabricate(:code)
    bank = Fabricate(:bank)
    client = Fabricate(:client)

    within '.form-inputs' do
      fill_in 'movement_auto_code_number', with: code.number
      select_first_autocomplete_item('#movement_auto_code_number')

      fill_in Movement.human_attribute_name('mov_number'), with: rand(999999)
      fill_in Movement.human_attribute_name('amount'), with: 100 * rand
      fill_in Movement.human_attribute_name('total_amount'), with: 100 * rand
      fill_in Movement.human_attribute_name('devoted'), with: 'Someone'
      fill_in Movement.human_attribute_name('charged_at'),
        with: I18n.l(3.days.ago.to_date)
      fill_in Movement.human_attribute_name('devoted_at'),
        with: I18n.l(Time.zone.today.to_date)
      fill_in Movement.human_attribute_name('deposited_in'), with: 'RED'

      fill_in 'movement_auto_client_name', with: client.name
      select_first_autocomplete_item('#movement_auto_client_name')
      fill_in 'movement_auto_bank_name', with: bank.name
      select_first_autocomplete_item('#movement_auto_bank_name')

      fill_in Movement.human_attribute_name('comment'),
        with: Faker::Lorem.paragraph
    end

    assert_difference 'Movement.count' do
      click_button I18n.t(
        'helpers.submit.create', model: Movement.model_name.human
      )
    end

    movement = Movement.reorder('id DESC').first
    assert_page_has_no_errors!
    assert_equal movement_path(movement), current_path
  end
 
  test 'should modifier a movement' do
    login

    visit edit_movement_path(@movement)

    assert_page_has_no_errors!
    assert_equal edit_movement_path(@movement), current_path
    assert page.has_css?('.form-inputs')
  
    within '.form-inputs' do
      fill_in Movement.human_attribute_name('amount'), with: 123
    end

    assert_no_difference 'Movement.count' do
      assert_difference 'Version.count' do
        click_button I18n.t(
          'helpers.submit.update', model: Movement.model_name.human
        )
      end
    end
  end
end
