require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should create post when signed in" do
    sign_in users(:one)

    assert_difference("Post.count", 1) do
      post kukai_posts_url(kukais(:one)), params: {
        post: {
          keyword_id: keywords(:one).id,
          verse: "テスト川柳"
        }
      }
    end

    assert_redirected_to kukai_url(kukais(:one))
  end

  test "turbo create form keeps kukai keywords only" do
    sign_in users(:one)

    post kukai_posts_url(kukais(:one), format: :turbo_stream), params: {
      post: {
        keyword_id: keywords(:one).id,
        verse: "テスト川柳"
      }
    }

    assert_response :success
    assert_includes response.body, keywords(:one).word
    assert_no_match(/#{Regexp.escape(keywords(:two).word)}/, response.body)
  end

  test "turbo create without keyword re-renders form without adding a post" do
    sign_in users(:one)

    assert_no_difference("Post.count") do
      post kukai_posts_url(kukais(:one), format: :turbo_stream), params: {
        post: {
          verse: "お題なし"
        }
      }
    end

    assert_response :success
    assert_includes response.body, "お題を選んでください。"
    assert_no_match(/turbo-stream action="prepend" target="posts"/, response.body)
  end

  test "turbo create without verse asks for verse" do
    sign_in users(:one)

    assert_no_difference("Post.count") do
      post kukai_posts_url(kukais(:one), format: :turbo_stream), params: {
        post: {
          keyword_id: keywords(:one).id,
          verse: ""
        }
      }
    end

    assert_response :success
    assert_includes response.body, "川柳を入力してください。"
    assert_no_match(/turbo-stream action="prepend" target="posts"/, response.body)
  end

  test "should redirect create when signed out" do
    assert_no_difference("Post.count") do
      post kukai_posts_url(kukais(:one)), params: {
        post: {
          keyword_id: keywords(:one).id,
          verse: "テスト川柳"
        }
      }
    end

    assert_redirected_to new_user_session_url
  end
end
