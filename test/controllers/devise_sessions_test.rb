require "test_helper"

class DeviseSessionsTest < ActionDispatch::IntegrationTest
  test "user can sign up with email and nickname" do
    assert_difference("User.count", 1) do
      post user_registration_url, params: {
        user: {
          email: "signup_user@example.com",
          nickname: "signup_user",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_redirected_to root_url
    assert_equal "signup_user", User.order(:created_at).last.nickname
  end

  test "user can sign in with nickname" do
    post user_session_url, params: {
      user: {
        login: "user_one",
        password: "password"
      }
    }

    assert_redirected_to root_url
  end
end
