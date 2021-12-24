require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'validation email' do
    user1 = FactoryBot.build(:user, email: '')
    assert_equal user1.valid?, false
    assert_includes user1.errors.messages[:email], "can't be blank"
    assert_includes user1.errors.messages[:email], "is invalid"

    user2 = FactoryBot.build(:user, email: 'user')
    assert_equal user2.valid?, false
    assert_includes user1.errors.messages[:email], "is invalid"

    user3 = FactoryBot.create(:user)
    user4 = FactoryBot.build(:user, email: user3.email)
    assert_equal user4.valid?, false
    assert_includes user1.errors.messages[:email], "is invalid"
  end

  test 'validation password' do
    user1 = FactoryBot.build(:user, password: '')
    assert_equal user1.valid?, false
    assert_includes user1.errors.messages[:password], "can't be blank"
  end

  test "method state_voting_movie" do
    user = FactoryBot.create(:user)
    movie1 = FactoryBot.create(:movie)
    assert_nil user.state_voting_movie(movie1)

    user.votes.create(movie_id: movie1.id, state: 'voted_up')
    assert_equal user.state_voting_movie(movie1), 'voted_up'

    movie2 = FactoryBot.create(:movie, youtube_id: 'B' * 11)
    user.votes.create(movie_id: movie2.id, state: 'voted_down')
    assert_equal user.state_voting_movie(movie2), 'voted_down'
  end
end
