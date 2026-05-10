require "test_helper"

class AdminKeywordsControllerTest < ActionDispatch::IntegrationTest
  test "admin should get index" do
    sign_in users(:one)

    get admin_keywords_url

    assert_response :success
    assert_includes response.body, keywords(:one).word
  end

  test "non admin should be redirected from index" do
    sign_in users(:two)

    get admin_keywords_url

    assert_redirected_to root_url
  end

  test "admin should update keyword" do
    sign_in users(:one)

    patch admin_keyword_url(keywords(:one)), params: {
      keyword: {
        word: "小雨",
        reading: "コサメ",
        pos: "名詞",
        category: "自然",
        len: 3
      }
    }

    assert_redirected_to admin_keywords_url
    assert_equal "小雨", keywords(:one).reload.word
  end
end
