require 'test_helper'

class WorkplaceTest < ActiveSupport::TestCase

  def setup
    @workplace = Fabricate(:workplace)
  end

  test 'create' do
    assert_difference 'Workplace.count' do
      @workplace = Workplace.create(Fabricate.attributes_for(:workplace))
    end
  end

  test 'update' do
    assert_no_difference 'Workplace.count' do
      assert @workplace.update_attributes(address: 'Upd'),
        @workplace.errors.full_messages.join('; ')
    end

    assert_equal 'Upd', @workplace.reload.address
  end

  test 'destroy' do
    assert_difference 'Version.count' do
      assert_difference('Workplace.count', -1) { @workplace.destroy }
    end
  end 

  test 'validates blank attributes' do
    @workplace.address = ''
    @workplace.country = ''
    @workplace.state = ''
    @workplace.client_id = ''

    assert @workplace.invalid?
    assert_equal 4, @workplace.errors.size
    assert_equal [error_message_from_model(@workplace, :address, :blank)], 
      @workplace.errors[:address]
    assert_equal [error_message_from_model(@workplace, :country, :blank)],  
      @workplace.errors[:country]
    assert_equal [error_message_from_model(@workplace, :state, :blank)],  
      @workplace.errors[:state]
    assert_equal [error_message_from_model(@workplace, :client_id, :blank)],   
      @workplace.errors[:client_id]
  end

  test 'validates unique attributes' do
    new_workplace = Fabricate(:workplace)
    @workplace.address = new_workplace.address

    assert @workplace.invalid?
    assert_equal 1, @workplace.errors.size
    assert_equal [error_message_from_model(@workplace, :address, :taken)],
      @workplace.errors[:address]
  end 
end
