require "test_helper"

class UserPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_posts_url(users(:one))
    assert_response :success
  end
end
