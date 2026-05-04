require "test_helper"

class PostRevisionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get post_revisions_show_url
    assert_response :success
  end
end
