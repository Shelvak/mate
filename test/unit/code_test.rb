require 'test_helper'

class CodeTest < ActiveSupport::TestCase
  def setup
    @code = Fabricate(:code)
  end

  test 'create' do
    assert_difference 'Code.count' do
      @code = Code.create(Fabricate.attributes_for(:code))
    end
  end

  test 'update' do
    assert_no_difference 'Code.count' do
      assert @code.update_attributes(detail: 'Someone'),
        @code.errors.full_messages.join('; ')
    end

    assert_equal 'Someone', @code.reload.detail
  end

  test 'destroy' do
    assert_difference 'Version.count' do
      assert_difference('Code.count', -1) { @code.destroy }
    end
  end 

  test 'validates blank attributes' do
    @code.detail = ''
    @code.number = ''

    assert @code.invalid?
    assert_equal 2, @code.errors.size
    assert_equal [error_message_from_model(@code, :detail, :blank)], 
      @code.errors[:detail]
    assert_equal [error_message_from_model(@code, :number, :blank)],  
      @code.errors[:number]
  end

  test 'validates unique attributes' do
    new_code = Fabricate(:code)
    @code.number = new_code.number

    assert @code.invalid?
    assert_equal 1, @code.errors.size
    assert_equal [error_message_from_model(@code, :number, :taken)],
      @code.errors[:number]
  end 
end
