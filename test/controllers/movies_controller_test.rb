require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
  include Support::AuthenticationHelperTest

  test "logged in user should get share page" do
    sign_in_as
    get '/share'
    assert_response :success
  end

  test "unable get share page without authenticated" do
    get '/share'
    assert_response 302
  end

  test "able to get index page" do
    get '/'
    assert_response :success
  end
end
