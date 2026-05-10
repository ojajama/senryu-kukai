require "test_helper"

class KukaisControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get kukais_url
    assert_response :success
    assert_includes response.body, kukais(:one).title
    assert_no_match(/#{Regexp.escape(kukais(:two).title)}/, response.body)
  end

  test "should get show" do
    get kukai_url(kukais(:one))
    assert_response :success
  end
end
