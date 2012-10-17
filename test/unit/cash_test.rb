require 'test_helper'

class CashTest < ActiveSupport::TestCase
  def setup
    @cash = Fabricate(:cash)
  end

  test 'create' do
    assert_difference ['Cash.count', 'Version.count'] do
      @cash = Cash.create(Fabricate.attributes_for(:cash))
    end 
  end
    
  test 'destroy' do 
    assert_difference 'Version.count' do
      assert_difference('Cash.count', -1) { @cash.destroy }
    end
  end
    
  test 'validates blank attributes' do
    @cash.amount = ''
    @cash.detail = ''
    
    assert @cash.invalid?
    assert_equal 2, @cash.errors.size
    assert_equal [error_message_from_model(@cash, :amount, :blank)],
      @cash.errors[:amount]
    assert_equal [error_message_from_model(@cash, :detail, :blank)],
      @cash.errors[:detail]
  end
    
  test 'validates unique attributes' do
    new_cash = Fabricate(:cash)
    @cash.detail = new_cash.detail

    assert @cash.invalid?
    assert_equal 1, @cash.errors.size
    assert_equal [error_message_from_model(@cash, :detail, :taken)],
      @cash.errors[:detail]
  end

  test 'validates numerical attributes' do
    @cash.amount = '11a'

    assert @cash.invalid?
    assert_equal 1, @cash.errors.size
    assert_equal [error_message_from_model(@cash, :amount, :not_a_number)],
      @cash.errors[:amount]
  end
end
