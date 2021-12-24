require "test_helper"

class VoteTest < ActiveSupport::TestCase
  test "validation" do
    vote1 = FactoryBot.create(:vote)
    vote2 = FactoryBot.build(:vote, user_id: vote1.user_id, movie_id: vote1.movie_id)
    assert_equal vote2.valid?, false

    vote3 = FactoryBot.build(:vote, state: nil)
    assert_equal vote3.valid?, false
  end
end
