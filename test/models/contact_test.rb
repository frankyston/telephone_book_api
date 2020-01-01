require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test 'contact be valid' do
    contact = Contact.new(first_name: 'Carolyn', phone: '85991929393', user_id: @user.id)
    assert contact.valid?
  end

  test 'contact be invalid' do
    contact = Contact.new(first_name: 'Carolyn', user_id: @user.id)
    assert_not contact.valid?
  end
end
