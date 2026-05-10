require "test_helper"

class AdminKukaisControllerTest < ActionDispatch::IntegrationTest
  test "admin should get index" do
    sign_in users(:one)

    get admin_kukais_url

    assert_response :success
    assert_includes response.body, kukais(:one).title
  end

  test "non admin should be redirected from index" do
    sign_in users(:two)

    get admin_kukais_url

    assert_redirected_to root_url
  end

  test "admin should get new" do
    sign_in users(:one)

    get new_admin_kukai_url

    assert_response :success
  end

  test "admin should create kukai with random keywords" do
    sign_in users(:one)

    assert_difference("Kukai.count", 1) do
      post admin_kukais_url, params: {
        kukai: {
          title: "2026年6月句会",
          year: 2026,
          month: 6
        },
        keyword_count: 2
      }
    end

    assert_redirected_to admin_kukais_url
    assert_equal 2, Kukai.order(:created_at).last.keywords.count
  end
end
