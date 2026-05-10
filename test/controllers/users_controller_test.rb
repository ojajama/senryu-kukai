require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_url

    assert_response :success
    assert_includes response.body, users(:one).nickname
  end
end
