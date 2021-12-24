require "test_helper"

class MoviesIndexTest < ActionDispatch::IntegrationTest
  include Support::AuthenticationHelperTest

  let(:user1) { FactoryBot.create(:user, email: 'user1@example.com') }
  let(:user2) { FactoryBot.create(:user, email: 'user2@example.com') }
  let(:movie1) { FactoryBot.create(:movie, user: user1, youtube_id: 'A' * 11,
                                   title: 'Movie 1 title', description: 'Movie 1 description') }
  let(:movie2) { FactoryBot.create(:movie, user: user2, youtube_id: 'B' * 11,
                                   title: 'Movie 2 title', description: 'Movie 2 description') }

  setup do
    movie1
    movie2
    get '/'
  end

  test 'Display correct movie information' do
    assert_equal(assert_select('#movie-details').size, 2)
    first_block_movie = assert_select('#movie-details').first
    last_block_movie = assert_select('#movie-details').last

    assert_equal(first_block_movie.search('.movie_title').text, 'Movie 2 title')
    assert_equal(first_block_movie.search('.movie_title').attribute('href').value, "https://youtu.be/BBBBBBBBBBB")
    assert_includes(first_block_movie.search('.author').text, 'user2@example.com')
    assert_includes(first_block_movie.search('.description').text, 'Movie 2 description')

    assert_equal(last_block_movie.search('.movie_title').text, 'Movie 1 title')
    assert_equal(last_block_movie.search('.movie_title').attribute('href').value, "https://youtu.be/AAAAAAAAAAA")
    assert_includes(last_block_movie.search('.author').text, 'user1@example.com')
    assert_includes(last_block_movie.search('.description').text, 'Movie 1 description')
  end

  test "Unauthenticated user unable to see button vote." do
    first_block_movie = assert_select('#movie-details').first
    assert_equal(first_block_movie.search('.vote').size, 0)
  end

  test "Authenticated user able to see vote up or vote down" do
    sign_in_as(user1)
    get '/'
    first_block_movie = assert_select('#movie-details').first
    assert_equal(first_block_movie.search('.vote').size, 1)
  end

  test "Authenticated user able to vote up or vote down" do
    sign_in_as(user1)
    assert_difference('user1.voting_movies.count', 1) do
      put vote_movies_path(format: 'js'), params: { movie_id: Movie.first.id, vote_option: 'voted_up' }
    end
  end
end
