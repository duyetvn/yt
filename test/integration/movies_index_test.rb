require "test_helper"

class MoviesIndexTest < ActionDispatch::IntegrationTest
  setup do
    user1 = FactoryBot.create(:user, email: 'user1@example.com')
    user2 = FactoryBot.create(:user, email: 'user2@example.com')
    FactoryBot.create(:movie, user: user1, youtube_id: 'A' * 11,
                               title: 'Movie 1 title', description: 'Movie 1 description')
    FactoryBot.create(:movie, user: user2, youtube_id: 'B' * 11,
                               title: 'Movie 2 title', description: 'Movie 2 description')
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
end
