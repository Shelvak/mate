require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  def setup
    @place = Fabricate(:place)
  end

  test 'create' do
    assert_difference 'Place.count' do
      @place = Place.create(Fabricate.attributes_for(:place))
    end 
  end
    
  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'Place.count' do
        assert @place.update_attributes(name: 'Updated')
      end
    end

    assert_equal 'Updated', @place.reload.name
  end
    
  test 'destroy' do 
    assert_difference 'Version.count' do
      assert_difference('Place.count', -1) { @place.destroy }
    end
  end
    
  test 'validates blank attributes' do
    @place.name = ''
    
    assert @place.invalid?
    assert_equal 1, @place.errors.size
    assert_equal [error_message_from_model(@place, :name, :blank)],
      @place.errors[:name]
  end
    
  test 'validates unique attributes' do
    new_place = Fabricate(:place)
    @place.name = new_place.name

    assert @place.invalid?
    assert_equal 1, @place.errors.size
    assert_equal [error_message_from_model(@place, :name, :taken)],
      @place.errors[:name]
  end
end
