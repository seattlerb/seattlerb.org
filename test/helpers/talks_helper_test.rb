require "minitest_helper"

class TalksHelperTest < MiniTest::Rails::ActionView::TestCase
  def test_indefinite_Articlerize
    assert_equal "A beginner", indefinite_Articlerize("beginner")
    assert_equal "An intermediate", indefinite_Articlerize("intermediate")
    assert_equal "An advanced", indefinite_Articlerize("advanced")
    assert_equal "A lightning", indefinite_Articlerize("lightning")
  end

  def test_talk_kinds
    expected = [["Beginner", "beginner"],
                ["Intermediate", "intermediate"],
                ["Advanced", "advanced"],
                ["Lightning", "lightning"],
                ["Talk Type", ""]]

    assert_equal expected.sort, talk_kinds.sort
  end
end
