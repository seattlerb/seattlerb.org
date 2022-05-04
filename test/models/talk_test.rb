require "minitest_helper"

class TalkTest < ActiveSupport::TestCase
  def talk_new attribs
    @event.talks.build attribs
  end

  def setup
    @event = Event.create! date: Date.today
  end

  def test_talks_restricted_to_specific_types
    beginner     = talk_new(:kind      => "beginner",
                            :title     => "A",
                            :email     => "a@example.com",
                            :presenter => "A")
    intermediate = talk_new(:kind      => "intermediate",
                            :title     => "A",
                            :email     => "a@example.com",
                            :presenter => "A")
    advanced     = talk_new(:kind      => "advanced",
                            :title     => "A",
                            :email     => "a@example.com",
                            :presenter => "A")
    lightning    = talk_new(:kind      => "lightning",
                            :title     => "A",
                            :email     => "a@example.com",
                            :presenter => "A")

    assert_predicate beginner,     :valid?
    assert_predicate intermediate, :valid?
    assert_predicate advanced,     :valid?
    assert_predicate lightning,    :valid?

    invalid = talk_new(:kind      => "invalid",
                       :title     => "A",
                       :presenter => "A")

    refute_predicate invalid, :valid?
  end

  def test_talks_must_have_title_kind_and_presenter
    minimum = talk_new(:kind      => "beginner",
                       :title     => "My Awesome Talk",
                       :email     => "a@example.com",
                       :presenter => "Dude")

    assert_predicate minimum, :valid?

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

    refute_predicate no_title,     :valid?
    refute_predicate no_kind,      :valid?
    refute_predicate no_presenter, :valid?
    refute_predicate no_email,     :valid?
  end

  def test_completed_talks_not_in_default_scope
    talk = talk_new(:title       => "Test Talk",
                    :presenter   => "Dude Number 1",
                    :email       => "a@example.com",
                    :kind        => "beginner",
                    :completed   => true)

    assert_predicate talk, :completed?
    refute_includes Talk.available, talk
  end
end
