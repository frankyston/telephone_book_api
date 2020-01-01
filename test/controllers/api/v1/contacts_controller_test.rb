require 'test_helper'

class Api::V1::ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact = contacts(:one)
  end

  test 'should create contact' do
    post api_v1_contacts_url, params: {
      contact: {
        first_name: 'Didi',
        last_name: 'Moco',
        phone: '85991929293',
        street: 'Rua x',
        neighborhood: 'Bairro Y',
        city: 'Cidade W',
        state: 'Estado Z',
        birthday: '1987-05-10',
        user_id: @contact.user_id
      }
    },
    headers: {
      Authorization: JsonWebToken.encode(user_id: @contact.user_id)
    }, as: :json

    assert_response :created
  end

  test 'should not create contact' do
    post api_v1_contacts_url, params: {
      contact: {
        first_name: 'Didi',
        last_name: 'Moco',
        street: 'Rua x',
        neighborhood: 'Bairro Y',
        city: 'Cidade W',
        state: 'Estado Z',
        birthday: '1987-05-10',
        user_id: @contact.user_id
      }
    },
    headers: {
      Authorization: JsonWebToken.encode(user_id: @contact.user_id)
    }, as: :json

    assert_response :unprocessable_entity
  end
end
