require "test_helper"

class KukaiKeywordsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get kukai_keyword_url(kukais(:one), keywords(:one))
    assert_response :success
  end
end
