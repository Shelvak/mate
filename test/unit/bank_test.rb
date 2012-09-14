require 'test_helper'

class BankTest < ActiveSupport::TestCase

  def setup
    @bank = Fabricate(:bank)
  end

  test 'create' do
    assert_difference ['Bank.count', 'Version.count'] do
      @bank = Bank.create(Fabricate.attributes_for(:bank))
    end
  end
  
  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'Bank.count' do
        assert @bank.update_attributes(name: 'Nation Bank')
      end
    end
    
    assert_equal 'Nation Bank', @bank.reload.name
  end
  
  test 'destroy' do
    assert_difference 'Version.count' do
      assert_difference('Bank.count', -1) { @bank.destroy }
    end
  end
  
  test 'validates blank attributes' do
    @bank.name = ''
      
    assert @bank.invalid?
    assert_equal 1, @bank.errors.size
    assert_equal [error_message_from_model(@bank, :name, :blank)],
      @bank.errors[:name]
  end
  
  test 'validates unique attributes' do
    new_bank = Fabricate(:bank)
    @bank.name = new_bank.name

    assert @bank.invalid?
    assert_equal 1, @bank.errors.size
    assert_equal [error_message_from_model(@bank, :name, :taken)],
      @bank.errors[:name]
  end 
  
  test 'magick search' do
    3.times { Fabricate(:bank, name: "Nation #{rand(99)}") }
    
    banks = Bank.magick_search('nation')
    
    assert_equal 3, banks.count
    assert banks.all? { |u| u.to_s =~ /Nation/ }
    
    banks = Bank.magick_search('inexisten')
    
    assert banks.empty?
  end
end
