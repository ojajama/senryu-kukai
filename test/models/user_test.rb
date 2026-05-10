require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "finds user by nickname for database authentication" do
    user = User.find_for_database_authentication(login: "user_one")

    assert_equal users(:one), user
  end

  test "finds user by email for database authentication" do
    user = User.find_for_database_authentication(login: "user_one@example.com")

    assert_equal users(:one), user
  end

  test "nickname must be unique ignoring case" do
    user = User.new(
      email: "other@example.com",
      nickname: "USER_ONE",
      password: "password"
    )

    assert_not user.valid?
    assert_includes user.errors[:nickname], "はすでに存在します"
  end
end
