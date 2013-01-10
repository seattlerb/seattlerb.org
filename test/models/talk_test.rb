require "minitest_helper"

class TalkTest < MiniTest::Rails::ActiveSupport::TestCase
  def test_talks_restricted_to_specific_types
    beginner     = Talk.new(:kind      => "beginner",
                            :title     => "A",
                            :email     => "a@example.com",
                            :presenter => "A")
    intermediate = Talk.new(:kind      => "intermediate",
                            :title     => "A",
                            :email     => "a@example.com",
                            :presenter => "A")
    advanced     = Talk.new(:kind      => "advanced",
                            :title     => "A",
                            :email     => "a@example.com",
                            :presenter => "A")
    lightning    = Talk.new(:kind      => "lightning",
                            :title     => "A",
                            :email     => "a@example.com",
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
    minimum = Talk.new(:kind      => "beginner",
                       :title     => "My Awesome Talk",
                       :email     => "a@example.com",
                       :presenter => "Dude")

    assert minimum.valid?

    no_title     = Talk.new(:kind      => "beginner",
                            :email     => "a@example.com",
                            :presenter => "Dude")
    no_kind      = Talk.new(:title     => "My Awesome Talk",
                            :email     => "a@example.com",
                            :presenter => "Dude")
    no_presenter = Talk.new(:kind      => "beginner",
                            :email     => "a@example.com",
                            :title     => "My Awesome Talk")
    no_email     = Talk.new(:kind      => "beginner",
                            :title     => "My Awesome Talk",
                            :presenter => "Dude")

    refute no_title.valid?
    refute no_kind.valid?
    refute no_presenter.valid?
    refute no_email.valid?
  end

  def test_completed_talks_not_in_default_scope
    talk = Talk.create!(:title       => "Test Talk",
                        :presenter   => "Dude Number 1",
                        :email       => "a@example.com",
                        :kind        => "beginner",
                        :completed   => true)

    assert talk.completed?
    refute_includes Talk.available, talk
  end

  def test_talk_scheduled_date
    talk = Talk.create!(:title          => "Test Talk",
                        :presenter      => "Dude Number 1",
                        :email          => "a@example.com",
                        :kind           => "beginner",
                        :scheduled_date => 3.months.from_now)

    assert talk.scheduled?
  end
end
