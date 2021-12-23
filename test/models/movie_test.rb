require "test_helper"

class MovieTest < ActiveSupport::TestCase
  test 'validation youtube_id' do
    movie1 = FactoryBot.build(:movie, youtube_id: '')
    assert_equal movie1.valid?, false
    assert_includes movie1.errors.messages[:youtube_id], "can't be blank"

    movie2 = FactoryBot.build(:movie, youtube_id: '1')
    assert_equal movie2.valid?, false
    assert_includes movie2.errors.messages[:youtube_id], "is the wrong length (should be 11 characters)"

    movie3 = movies(:valid_1)
    user = FactoryBot.create(:user)
    movie3.user = user
    movie3.save
    movie4 = FactoryBot.build(:movie, youtube_id: movie3.youtube_id)
    assert_equal movie4.valid?, false
    assert_includes movie4.errors.messages[:youtube_id], "has already been taken"
  end

  test 'validation title' do
    movie = movies(:invalid_title)
    user = FactoryBot.create(:user)
    movie.user = user
    assert_equal movie.valid?, false
    assert_includes movie.errors.messages[:title], "can't be blank"
  end
end
