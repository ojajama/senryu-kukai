require "test_helper"

class KukaiKeywordsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get kukai_keywords_show_url
    assert_response :success
  end
end
