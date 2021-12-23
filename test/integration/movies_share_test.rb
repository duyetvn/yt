require "test_helper"

class MoviesShareTest < ActionDispatch::IntegrationTest
  include Support::AuthenticationHelperTest

  let(:user) { FactoryBot.create(:user) }

  setup do
    sign_in_as(user)
    get '/'
  end

  test 'Share a valid youtube url' do
    url = 'https://www.youtube.com/watch?v=Ne5J4bxWypI'
    assert_difference('Movie.count', 1) do
      post '/', params: { movie: { youtube_url: url } }
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_includes(assert_select('#js__flash-area').text, 'Your movie was added.')
  end

  test 'Share a youtube url not found' do
    url = 'https://www.youtube.com/watch?v=111111111111'
    assert_no_difference('Movie.count') do
      post '/', params: { movie: { youtube_url: url } }
    end

    assert_response 200
    assert_includes(assert_select('#js__flash-area').text, 'Not found video on youtube.')
  end

  test 'Share an invalid youtube url' do
      url = 'hello'
    assert_no_difference('Movie.count') do
      post '/', params: { movie: { youtube_url: url } }
    end

    assert_response 200
    assert_includes(assert_select('#js__flash-area').text, 'Invalid Youtube Url')
  end
end
