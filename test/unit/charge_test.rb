require 'test_helper'

class ChargeTest < ActiveSupport::TestCase

  def setup
    @charge = Fabricate(:charge)
  end

  test 'create' do
    assert_difference ['Charge.count', 'Version.count'] do
      @charge = Charge.create(Fabricate.attributes_for(:charge))
    end
  end

  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'Charge.count' do
        assert @charge.update_attributes(amount: 35.5),
          @charge.errors.full_messages.join('; ')
      end
    end

    assert_equal 35.5, @charge.reload.amount
  end

  test 'destroy' do
    assert_difference 'Version.count' do
      assert_difference('Charge.count', -1) { @charge.destroy }
    end
  end 

  test 'validates blank attributes' do
    @charge.charged_at = ''
    @charge.amount = ''
    @charge.detail = ''
 
    assert @charge.invalid?
    assert_equal 3, @charge.errors.size
    assert_equal [error_message_from_model(@charge, :charged_at, :blank)], 
      @charge.errors[:charged_at]
    assert_equal [error_message_from_model(@charge, :amount, :blank)],  
      @charge.errors[:amount]
    assert_equal [error_message_from_model(@charge, :detail, :blank)],  
      @charge.errors[:detail]
  end

  test 'validates inclusion attributes' do
    @charge.state = nil 
    assert @charge.invalid?
    assert_equal 1, @charge.errors.count
    assert_equal [error_message_from_model(@charge, :state, :inclusion)],
      @charge.errors[:state]
  end

  test 'validates numericality attributes' do
    @charge.amount = '10x' 
    assert @charge.invalid?
    assert_equal 1, @charge.errors.count
    assert_equal [error_message_from_model(@charge, :amount, :not_a_number)],
      @charge.errors[:amount]
  end
end
