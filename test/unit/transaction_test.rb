require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  def setup
    @transaction = Fabricate(:transaction)
  end

  test 'create' do
    assert_difference 'Transaction.count' do
      @transaction = Transaction.create(Fabricate.attributes_for(:transaction))
    end
  end

  test 'update' do
    assert_no_difference 'Transaction.count' do
      assert @transaction.update_attributes(amount: 35.5),
        @transaction.errors.full_messages.join('; ')
    end

    assert_equal 35.5, @transaction.reload.amount
  end

  test 'destroy' do
    assert_difference 'Version.count' do
      assert_difference('Transaction.count', -1) { @transaction.destroy }
    end
  end 

  test 'validates blank attributes' do
    @transaction.charged_at = ''
    @transaction.amount = ''
    @transaction.expiration = ''
    @transaction.place_id = ''
    @transaction.card_id = ''

    assert @transaction.invalid?
    assert_equal 5, @transaction.errors.size
    assert_equal [error_message_from_model(@transaction, :charged_at, :blank)], 
      @transaction.errors[:charged_at]
    assert_equal [error_message_from_model(@transaction, :amount, :blank)],  
      @transaction.errors[:amount]
    assert_equal [error_message_from_model(@transaction, :expiration, :blank)],                              
      @transaction.errors[:expiration]
    assert_equal [error_message_from_model(@transaction, :place_id, :blank)],                              
      @transaction.errors[:place_id]
    assert_equal [error_message_from_model(@transaction, :card_id, :blank)],                              
      @transaction.errors[:card_id]
  end
end
