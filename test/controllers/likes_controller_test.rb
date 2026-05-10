require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  test "should create like when signed in" do
    sign_in users(:one)

    assert_difference("Like.count", 1) do
      post post_likes_url(posts(:two))
    end

    assert_redirected_to root_url
  end

  test "should destroy like when signed in" do
    sign_in users(:one)

    assert_difference("Like.count", -1) do
      delete post_like_url(posts(:one), likes(:one))
    end

    assert_redirected_to root_url
  end
end
