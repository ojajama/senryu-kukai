require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should create comment when signed in" do
    sign_in users(:one)

    assert_difference("Comment.count", 1) do
      post post_comments_url(posts(:one)), params: {
        comment: {
          body: "いい句ですね"
        }
      }
    end

    assert_redirected_to root_url
  end
end
