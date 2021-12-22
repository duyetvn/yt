require "test_helper"

class User::SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should create new user' do
    assert_difference("User.count") do
      post '/users/sessions', params: { users: { email: 'user@example.com', password: 'password' } }
    end

    assert_redirected_to '/'
    assert_equal 'Your account is created successfully', flash[:success]
  end

  test 'should sign in' do
    user = FactoryBot.create(:user)
    assert_no_difference("User.count") do
      post '/users/sessions', params: { users: { email: user.email, password: 'password' } }
    end

    assert_redirected_to '/'
    assert_equal 'Sign in successfully!', flash[:success]
  end
end
