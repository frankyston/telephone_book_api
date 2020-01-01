require 'test_helper'

class Api::V1::ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact = contacts(:one)
  end

  test 'should show contacts' do
    get api_v1_contacts_url,
    headers: {
      Authorization: JsonWebToken.encode(user_id: @contact.user.id)
    }, as: :json

    assert_response :success
  end

  test 'should show contact' do
    get api_v1_contact_url(@contact),
    headers: {
      Authorization: JsonWebToken.encode(user_id: @contact.user.id)
    }, as: :json

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal @contact.first_name, json_response['first_name']
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
