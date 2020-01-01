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

  test 'should create user' do
    post api_v1_users_url, params: {
      user: {
        email: 'test@teste.com',
        password: 'super123'
      }
    }, as: :json

    response_json = JSON.parse(response.body)
    assert_response :created
  end

  test 'should not create user with taken email' do
    post api_v1_users_url, params: {
      user: {
        email: @user.email,
        password: 'super123'
      }
    }, as: :json

    assert_response :unprocessable_entity
  end

  test 'should update user' do
    patch api_v1_user_url(@user),
    params: {
      user: { email: @user.email }
    },
    headers: {
      Authorization: JsonWebToken.encode(user_id: @user.id)
    }, as: :json

    assert_response :success
  end

  test 'should forbid update user' do
    patch api_v1_user_url(@user),
    params: {
      user: { email: @user.email }
    }, as: :json
    assert_response :forbidden
  end

  test 'should not update user without taken email' do
    patch api_v1_user_url(@user), params: {
      user: {
        email: 'bad_email',
        password: 'super123'
      },
      headers: {
        Authorization: JsonWebToken.encode(user_id: @user.id)
      }
    }, as: :json

    assert_response :forbidden
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete api_v1_user_url(@user),
      headers: {
        Authorization: JsonWebToken.encode(user_id: @user.id)
      }, as: :json
      assert_response :no_content
    end
  end

  test 'should forbid destroy user' do
    assert_no_difference('User.count') do
      delete api_v1_user_url(@user), as: :json
    end
    assert_response :forbidden
  end
end
