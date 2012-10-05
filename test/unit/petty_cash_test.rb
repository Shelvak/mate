require 'test_helper'

class PettyCashTest < ActiveSupport::TestCase

  def setup
    @petty_cash = Fabricate(:petty_cash)
  end

  test 'create' do
    assert_difference ['PettyCash.count', 'Version.count'] do
      @petty_cash = PettyCash.create(Fabricate.attributes_for(:petty_cash))
    end
  end

  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'PettyCash.count' do
        assert @petty_cash.update_attributes(amount: 35.5),
          @petty_cash.errors.full_messages.join('; ')
      end
    end

    assert_equal 35.5, @petty_cash.reload.amount
  end

  test 'destroy' do
    assert_difference 'Version.count' do
      assert_difference('PettyCash.count', -1) { @petty_cash.destroy }
    end
  end 

  test 'validates blank attributes' do
    @petty_cash.charged_at = ''
    @petty_cash.amount = ''
    @petty_cash.detail = ''
 
    assert @petty_cash.invalid?
    assert_equal 3, @petty_cash.errors.size
    assert_equal [error_message_from_model(@petty_cash, :charged_at, :blank)], 
      @petty_cash.errors[:charged_at]
    assert_equal [error_message_from_model(@petty_cash, :amount, :blank)],  
      @petty_cash.errors[:amount]
    assert_equal [error_message_from_model(@petty_cash, :detail, :blank)],  
      @petty_cash.errors[:detail]
  end

  test 'validates inclusion attributes' do
    @petty_cash.state = nil 
    assert @petty_cash.invalid?
    assert_equal 1, @petty_cash.errors.count
    assert_equal [error_message_from_model(@petty_cash, :state, :inclusion)],
      @petty_cash.errors[:state]
  end

  test 'validates numericality attributes' do
    @petty_cash.amount = '10x' 
    assert @petty_cash.invalid?
    assert_equal 1, @petty_cash.errors.count
    assert_equal [
      error_message_from_model(@petty_cash, :amount, :not_a_number)
    ], @petty_cash.errors[:amount]
  end
end
