require "test_helper"

class SettingTest < ActiveSupport::TestCase
  test "the truth" do
    assert_equal locations(:one), Current.location

    Current.location = locations(:two)

    assert_equal locations(:two), Current.location
  end
end
