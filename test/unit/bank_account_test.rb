require 'test_helper'

class BankAccountTest < ActiveSupport::TestCase

  def setup
    @bank_account = Fabricate(:bank_account)
  end

  test 'create' do
    assert_difference ['BankAccount.count', 'Version.count'] do
      @bank_account = BankAccount.create(
        Fabricate.attributes_for(:bank_account)
      )
    end 
  end
    
  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'BankAccount.count' do
        assert @bank_account.update_attributes(office_number: 33)
      end
    end

    assert_equal 33, @bank_account.reload.office_number
  end
    
  test 'destroy' do 
    assert_difference 'Version.count' do
      assert_difference('BankAccount.count', -1) { @bank_account.destroy }
    end
  end
    
  test 'validates blank attributes' do
    @bank_account.number = ''
    @bank_account.office_number = ''
    @bank_account.kind = ''
    @bank_account.currency = ''
    @bank_account.bank_id = ''
    
    assert @bank_account.invalid?
    assert_equal 5, @bank_account.errors.size
    assert_equal [error_message_from_model(@bank_account, :number, :blank)],
      @bank_account.errors[:number]
    assert_equal [
      error_message_from_model(@bank_account, :office_number, :blank)
    ], @bank_account.errors[:office_number]
    assert_equal [error_message_from_model(@bank_account, :kind, :blank)],
      @bank_account.errors[:kind]
    assert_equal [error_message_from_model(@bank_account, :currency, :blank)],
      @bank_account.errors[:currency]
    assert_equal [error_message_from_model(@bank_account, :bank_id, :blank)],
      @bank_account.errors[:bank_id]
  end
    
  test 'validates unique attributes' do
    new_bank_account = Fabricate(:bank_account)
    @bank_account.number = new_bank_account.number

    assert @bank_account.invalid?
    assert_equal 1, @bank_account.errors.size, @bank_account.errors.full_messages
    assert_equal [error_message_from_model(@bank_account, :number, :taken)],
      @bank_account.errors[:number]
  end
end
