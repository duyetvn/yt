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
end
