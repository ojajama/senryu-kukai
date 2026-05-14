require "test_helper"

class PostRevisionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get post_revision_url(post_revisions(:one))
    assert_response :success
  end

  test "should get index" do
    get post_post_revisions_url(posts(:one))
    assert_response :success
  end

  test "restore with invalid target redirects with alert" do
    sign_in users(:one)
    patch restore_post_revision_url(post_revisions(:one)), params: { target: "invalid" }
    assert_redirected_to root_path
  end
end
