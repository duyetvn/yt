module Support
  module AuthenticationHelperTest
    def sign_in_as(user=nil)
      user ||= FactoryBot.create(:user)

      post "/users/sessions",
           params: { users: { email: user.email, password: "password" } }
      assert_response :redirect
      follow_redirect!
    end
  end
end
