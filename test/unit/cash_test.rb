require 'test_helper'

class CashTest < ActiveSupport::TestCase
  def setup
    @cash = Fabricate(:cash)
  end

  test 'create' do
    assert_difference 'Cash.count' do
      assert_difference 'Version.count', 2 do
        @cash = Cash.create(Fabricate.attributes_for(:cash))
      end
    end 
  end
    
  test 'destroy' do 
    assert_difference 'Version.count' do
      assert_difference('Cash.count', -1) { @cash.destroy }
    end
  end
    
  test 'validates blank attributes' do
    @cash.amount = ''
    
    assert @cash.invalid?
    assert_equal 1, @cash.errors.size
    assert_equal [error_message_from_model(@cash, :amount, :blank)],
      @cash.errors[:amount]
  end
    
  test 'validates numerical attributes' do
    @cash.amount = '11a'

    assert @cash.invalid?
    assert_equal 1, @cash.errors.size
    assert_equal [error_message_from_model(@cash, :amount, :not_a_number)],
      @cash.errors[:amount]
  end
end
