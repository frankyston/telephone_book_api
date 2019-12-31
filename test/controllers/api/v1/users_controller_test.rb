require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end
  
  test 'should show user' do
    get api_v1_user_url(@user), as: :json
    response_json = JSON.parse(response.body)
    assert_equal @user.email, response_json['email']
  end
end
