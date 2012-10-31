require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  def setup
    @client = Fabricate(:client)
  end

  test 'create' do
    assert_difference 'Client.count' do
      @client = Client.create(Fabricate.attributes_for(:client))
    end 
  end
    
  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'Client.count' do
        assert @client.update_attributes(name: 'Updated')
      end
    end

    assert_equal 'Updated', @client.reload.name
  end
    
  test 'destroy' do 
    assert_difference 'Version.count' do
      assert_difference('Client.count', -1) { @client.destroy }
    end
  end
    
  test 'validates blank attributes' do
    @client.name = ''
    @client.firm_name = ''
    @client.iva_responsive = ''
    @client.ident = ''
    
    assert @client.invalid?
    assert_equal 4, @client.errors.size
    assert_equal [error_message_from_model(@client, :name, :blank)],
      @client.errors[:name]
    assert_equal [error_message_from_model(@client, :firm_name, :blank)],
      @client.errors[:firm_name]
    assert_equal [error_message_from_model(@client, :ident, :blank)],
      @client.errors[:ident]
    assert_equal [error_message_from_model(@client, :iva_responsive, :blank)],
      @client.errors[:iva_responsive]
  end
    
  test 'validates unique attributes' do
    new_client = Fabricate(:client)
    @client.name = new_client.name
    @client.ident = new_client.ident

    assert @client.invalid?
    assert_equal 2, @client.errors.size
    assert_equal [error_message_from_model(@client, :name, :taken)],
      @client.errors[:name]
    assert_equal [error_message_from_model(@client, :ident, :taken)],
      @client.errors[:ident]
  end
end
