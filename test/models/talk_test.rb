require "minitest_helper"

class TalkTest < MiniTest::Rails::ActiveSupport::TestCase
  def test_creation
    talk = Talk.create!(:title       => "Test Talk",
                        :description => "Test Talk Description",
                        :presenter   => "Dude Number 1",
                        :kind        => "beginner")

    refute_nil talk
  end

  def test_talks_restricted_to_specific_types
    beginner     = Talk.new(:kind      => "beginner",
                            :title     => "A",
                            :presenter => "A")
    intermediate = Talk.new(:kind      => "intermediate",
                            :title     => "A",
                            :presenter => "A")
    advanced     = Talk.new(:kind      => "advanced",
                            :title     => "A",
                            :presenter => "A")
    lightning    = Talk.new(:kind      => "lightning",
                            :title     => "A",
                            :presenter => "A")

    assert beginner.valid?
    assert intermediate.valid?
    assert advanced.valid?
    assert lightning.valid?

    invalid = Talk.new(:kind      => "invalid",
                       :title     => "A",
                       :presenter => "A")
    refute invalid.valid?
  end

  def test_talks_must_have_title_kind_and_presenter
    minimum = Talk.new(:kind => "beginner", :title => "My Awesome Talk", :presenter => "Dude")

    assert minimum.valid?

    no_title     = Talk.new(:kind      => "beginner",
                            :presenter => "Dude")
    no_kind      = Talk.new(:title     => "My Awesome Talk",
                            :presenter => "Dude")
    no_presenter = Talk.new(:kind      => "beginner",
                            :title     => "My Awesome Talk")

    refute no_title.valid?
    refute no_kind.valid?
    refute no_presenter.valid?
  end
end
