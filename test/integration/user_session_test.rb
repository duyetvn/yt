require "test_helper"

class UserSessionTest < ActionDispatch::IntegrationTest
  let(:user) { FactoryBot.create(:user) }

  setup do
    get '/'
  end

  test 'Sign in successful' do
    post '/users/sessions',
         params: { users: { email: user.email, password: 'password' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'header .user-profiles', user.email
    assert_includes(assert_select('#js__flash-area').text, 'Sign in successfully!')
  end

  test 'Sign in failed - Wrong email password' do
    post '/users/sessions',
         params: { users: { email: "#{user.email}", password: 'password1' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'header .user-profiles', false
    assert_includes(assert_select('#js__flash-area').text, 'Wrong email or password.')
  end

  test 'Sign in failed - Invalid email' do
    post '/users/sessions',
         params: { users: { email: 'new_user', password: 'password' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'header .user-profiles', false
    assert_includes(assert_select('#js__flash-area').text, 'Email is invalid')
  end

  test 'Register new user' do
    post '/users/sessions',
         params: { users: { email: 'newuser@example.com', password: 'password' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'header .user-profiles', 'newuser@example.com'
    assert_includes(assert_select('#js__flash-area').text, 'Your account is created successfully')
  end
end
