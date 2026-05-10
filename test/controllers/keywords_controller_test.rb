require "test_helper"

class KeywordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get keywords_url
    assert_response :success
  end
end
