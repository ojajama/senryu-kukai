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

  test "admin should get edit" do
    sign_in users(:one)

    get edit_admin_kukai_url(kukais(:one))

    assert_response :success
    assert_includes response.body, keywords(:one).word
  end

  test "admin should update kukai" do
    sign_in users(:one)

    patch admin_kukai_url(kukais(:one)), params: {
      kukai: {
        title: "更新した句会",
        year: 2026,
        month: 7,
        visible: "0"
      }
    }

    assert_redirected_to admin_kukais_url
    kukais(:one).reload
    assert_equal "更新した句会", kukais(:one).title
    assert_equal 2026, kukais(:one).year
    assert_equal 7, kukais(:one).month
    assert_not kukais(:one).visible?
  end

  test "admin should add random keyword" do
    sign_in users(:one)

    assert_difference("KukaiKeyword.count", 1) do
      post add_random_keyword_admin_kukai_url(kukais(:one))
    end

    assert_redirected_to edit_admin_kukai_url(kukais(:one))
  end

  test "admin should remove keyword" do
    sign_in users(:one)

    assert_difference("KukaiKeyword.count", -1) do
      delete keyword_admin_kukai_url(kukais(:one), keywords(:one))
    end

    assert_redirected_to edit_admin_kukai_url(kukais(:one))
  end
end
