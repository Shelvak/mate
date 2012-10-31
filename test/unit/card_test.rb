require 'test_helper'

class CardTest < ActiveSupport::TestCase

  def setup
    @card = Fabricate(:card)
  end

  test 'create' do
    assert_difference 'Card.count' do
      @card = Card.create(Fabricate.attributes_for(:card))
    end
  end

  test 'update' do
    assert_no_difference 'Card.count' do
      assert @card.update_attributes(name: 'Upd'),
        @card.errors.full_messages.join('; ')
    end

    assert_equal 'Upd', @card.reload.name
  end

  test 'destroy' do
    assert_difference 'Version.count' do
      assert_difference('Card.count', -1) { @card.destroy }
    end
  end 

  test 'validates blank attributes' do
    @card.name = ''
    @card.number = ''
    @card.expire_at = ''

    assert @card.invalid?
    assert_equal 3, @card.errors.size
    assert_equal [error_message_from_model(@card, :name, :blank)], 
      @card.errors[:name]
    assert_equal [error_message_from_model(@card, :number, :blank)], 
      @card.errors[:number]
    assert_equal [error_message_from_model(@card, :expire_at, :blank)], 
      @card.errors[:expire_at]
  end

  test 'validates unique attributes' do
    new_card = Fabricate(:card)
    @card.number = new_card.number

    assert @card.invalid?
    assert_equal 1, @card.errors.size
    assert_equal [error_message_from_model(@card, :number, :taken)],
      @card.errors[:number]
  end 
end
