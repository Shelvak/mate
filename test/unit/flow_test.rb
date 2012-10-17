require 'test_helper'

class FlowTest < ActiveSupport::TestCase
  def setup
    @flow = Fabricate(:flow)
  end

  test 'create' do
    assert_difference ['Flow.count', 'Version.count'] do
      @flow = Flow.create(Fabricate.attributes_for(:flow))
    end 
  end
    
  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'Flow.count' do
        assert @flow.update_attributes(detail: 'Updated')
      end
    end

    assert_equal 'Updated', @flow.reload.detail
  end
    
  test 'destroy' do 
    assert_difference 'Version.count' do
      assert_difference('Flow.count', -1) { @flow.destroy }
    end
  end
    
  test 'validates blank attributes' do
    @flow.code = ''
    @flow.subcode = ''
    @flow.charged_at = ''
    @flow.detail = ''
    @flow.total_amount = ''
    
    assert @flow.invalid?
    assert_equal 5, @flow.errors.size
    assert_equal [error_message_from_model(@flow, :code, :blank)],
      @flow.errors[:code]
    assert_equal [error_message_from_model(@flow, :subcode, :blank)],
      @flow.errors[:subcode]
    assert_equal [error_message_from_model(@flow, :charged_at, :blank)],
      @flow.errors[:charged_at]
    assert_equal [error_message_from_model(@flow, :detail, :blank)],
      @flow.errors[:detail]
    assert_equal [error_message_from_model(@flow, :total_amount, :blank)],
      @flow.errors[:total_amount]
  end
end
