require "test_helper"

class KukaiTest < ActiveSupport::TestCase
  test "assigns random keywords" do
    kukai = Kukai.create!(
      title: "2026年6月句会",
      year: 2026,
      month: 6
    )

    kukai.assign_random_keywords!(2)

    assert_equal 2, kukai.keywords.count
  end
end
