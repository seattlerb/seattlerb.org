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
    beginner     = Talk.new(:kind => "beginner")
    intermediate = Talk.new(:kind => "intermediate")
    advanced     = Talk.new(:kind => "advanced")
    lightning    = Talk.new(:kind => "lightning")

    assert beginner.valid?
    assert intermediate.valid?
    assert advanced.valid?
    assert lightning.valid?

    invalid = Talk.new(:kind => "invalid")
    refute invalid.valid?
  end
end
