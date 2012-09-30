require 'test_helper'

class PlaceInteracionsTets < ActionDispatch::IntegrationTest
  setup do
    @place = Fabricate(:place)
  end
          
  test 'should create place' do
    login

    visit places_path

    assert_page_has_no_errors!
    assert_equal places_path, current_path

    click_link I18n.t('view.places.new')

    assert_page_has_no_errors!
    assert_equal new_place_path, current_path

    assert page.has_css?('.form-inputs')

    within '.form-inputs' do
      fill_in Place.human_attribute_name('name'), with: 'Argentina'
    end

    assert_difference 'Place.count' do
      click_button I18n.t(
        'helpers.submit.create', model: Place.model_name.human
      )
    end

    place = Place.order('id DESC').first
    assert_page_has_no_errors!
    assert_equal place_path(place), current_path
  end

  test 'should delete place' do
    login

    visit places_path

    assert_page_has_no_errors!
    assert_equal places_path, current_path
    assert page.has_css?('table tbody')

    within 'table tbody' do
      assert_difference 'Place.count', -1 do
        remove_data_confirm_attr
        find('a[data-method="delete"]').click
      end
    end

    assert_page_has_no_errors!
    assert_equal places_path, current_path
    assert page.has_css?(
      '.alert', text: I18n.t('view.places.correctly_deleted')
    )
  end

  test 'should edit a place' do
    login

    visit edit_place_path(@place)

    assert_page_has_no_errors!
    assert_equal edit_place_path(@place), current_path
    assert page.has_css?('.form-inputs')

    within '.form-inputs' do
      fill_in Place.human_attribute_name('name'), with: 'updated'
    end

    assert_no_difference 'Place.count' do
      click_button I18n.t(
        'helpers.submit.update', model: Place.model_name.human
      )
    end
  end
end



