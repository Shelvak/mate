require 'test_helper'

class MovementTest < ActiveSupport::TestCase

  def setup 
    @movement = Fabricate(:movement)
  end

  test 'create' do
    assert_difference 'Movement.count' do
      @movement = Fabricate(:movement)
    end
  end

  test 'update' do
    assert_no_difference 'Movement.count' do
      assert @movement.update_attributes(amount: 9999.00),
        @movement.errors.full_messages.join('; ')
    end

    assert_equal 9999.00, @movement.reload.amount
  end

  test 'destroy' do
    assert_difference 'Version.count' do
      assert_difference('Movement.count', -1) { @movement.destroy }
    end
  end
  
  test 'validates blank attributes' do
    @movement.charged_at = ''
    @movement.mov_number = ''
    @movement.amount = ''
    @movement.code_id = ''
    @movement.bank_id = ''
    @movement.client_id = ''
    
    assert @movement.invalid?
    assert_equal 6, @movement.errors.size
    assert_equal [error_message_from_model(@movement, :charged_at, :blank)], 
      @movement.errors[:charged_at]
    assert_equal [error_message_from_model(@movement, :mov_number, :blank)], 
      @movement.errors[:mov_number]
    assert_equal [error_message_from_model(@movement, :amount, :blank)], 
      @movement.errors[:amount]
    assert_equal [error_message_from_model(@movement, :code_id, :blank)], 
      @movement.errors[:code_id]
    assert_equal [error_message_from_model(@movement, :bank_id, :blank)], 
      @movement.errors[:bank_id]
    assert_equal [error_message_from_model(@movement, :client_id, :blank)], 
      @movement.errors[:client_id]
  end

  test 'validates uniq attributes' do
    new_movement = Fabricate(:movement)
    @movement.mov_number = new_movement.mov_number

    assert @movement.invalid?
    assert_equal 1, @movement.errors.size
    assert_equal [error_message_from_model(@movement, :mov_number, :taken)],
      @movement.errors[:mov_number]
  end

  test 'auto attr accessor names' do
    attrs = @movement.auto_attr_accessor_names

    assert attrs.size > 0
    assert_equal ['bank', 'client', 'code'].sort, attrs.sort
  end
end
