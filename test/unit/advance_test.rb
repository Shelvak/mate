require 'test_helper'

class AdvanceTest < ActiveSupport::TestCase

  def setup
    @advance = Fabricate(:advance)
  end

  test 'create' do
    assert_difference ['Advance.count', 'Version.count'] do
      @advance = Advance.create(Fabricate.attributes_for(:advance))
    end
  end

  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'Advance.count' do
        assert @advance.update_attributes(amount: 35.5),
          @advance.errors.full_messages.join('; ')
      end
    end

    assert_equal 35.5, @advance.reload.amount
  end

  test 'destroy' do
    assert_difference 'Version.count' do
      assert_difference('Advance.count', -1) { @advance.destroy }
    end
  end 

  test 'validates blank attributes' do
    @advance.charged_at = ''
    @advance.amount = ''
    @advance.detail = ''
 
    assert @advance.invalid?
    assert_equal 3, @advance.errors.size
    assert_equal [error_message_from_model(@advance, :charged_at, :blank)], 
      @advance.errors[:charged_at]
    assert_equal [error_message_from_model(@advance, :amount, :blank)],  
      @advance.errors[:amount]
    assert_equal [error_message_from_model(@advance, :detail, :blank)],  
      @advance.errors[:detail]
  end

  test 'validates inclusion attributes' do
    @advance.state = nil 
    assert @advance.invalid?
    assert_equal 1, @advance.errors.count
    assert_equal [error_message_from_model(@advance, :state, :inclusion)],
      @advance.errors[:state]
  end

  test 'validates numericality attributes' do
    @advance.amount = '10x' 
    assert @advance.invalid?
    assert_equal 1, @advance.errors.count
    assert_equal [error_message_from_model(@advance, :amount, :not_a_number)],
      @advance.errors[:amount]
  end
end
