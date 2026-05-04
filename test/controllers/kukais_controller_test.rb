require "test_helper"

class KukaisControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get kukais_show_url
    assert_response :success
  end
end
