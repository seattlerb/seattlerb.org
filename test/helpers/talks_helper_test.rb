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

  def test_scheduled_date
    event = Event.create(date: Date.new(2014, 1, 1))
    scheduled_talk    = Talk.create!(:title     => "Test Talk",
                                     :presenter => "Dude Number 1",
                                     :email     => "a@example.com",
                                     :kind      => "beginner",
                                     :event     => event)

    unscheduled_talk  = Talk.create!(:title     => "Test Talk Two",
                                     :presenter => "Dude Number 1",
                                     :email     => "a@example.com",
                                     :kind      => "beginner")

    assert_equal "Scheduled for January 1st, 2014.",
      scheduled_date(scheduled_talk)
    assert_equal "This talk has not been scheduled.",
    scheduled_date(unscheduled_talk)
  end
end
