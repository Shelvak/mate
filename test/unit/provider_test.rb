
require 'test_helper'

class ProviderTest < ActiveSupport::TestCase
  def setup
    @provider = Fabricate(:provider)
  end

  test 'create' do
    assert_difference 'Provider.count' do
      @provider = Provider.create(Fabricate.attributes_for(:provider))
    end 
  end
    
  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'Provider.count' do
        assert @provider.update_attributes(name: 'Updated')
      end
    end

    assert_equal 'Updated', @provider.reload.name
  end
    
  test 'destroy' do 
    assert_difference 'Version.count' do
      assert_difference('Provider.count', -1) { @provider.destroy }
    end
  end
    
  test 'validates blank attributes' do
    @provider.name = ''
    @provider.firm_name = ''
    @provider.iva_responsive = ''
    @provider.ident = ''
    
    assert @provider.invalid?
    assert_equal 4, @provider.errors.size
    assert_equal [error_message_from_model(@provider, :name, :blank)],
      @provider.errors[:name]
    assert_equal [error_message_from_model(@provider, :firm_name, :blank)],
      @provider.errors[:firm_name]
    assert_equal [error_message_from_model(@provider, :ident, :blank)],
      @provider.errors[:ident]
    assert_equal [error_message_from_model(@provider, :iva_responsive, :blank)],
      @provider.errors[:iva_responsive]
  end
    
  test 'validates unique attributes' do
    new_provider = Fabricate(:provider)
    @provider.name = new_provider.name
    @provider.ident = new_provider.ident

    assert @provider.invalid?
    assert_equal 2, @provider.errors.size
    assert_equal [error_message_from_model(@provider, :name, :taken)],
      @provider.errors[:name]
    assert_equal [error_message_from_model(@provider, :ident, :taken)],
      @provider.errors[:ident]
  end
end
