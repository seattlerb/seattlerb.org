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

  def test_invalid_with_proposed_month_less_than_january
    subject = Talk.new(kind: "beginner", title: "foo", presenter: "derp", email: "beep")
    assert subject.valid?
    subject.proposed_month = 0
    refute subject.valid?
  end

  def test_invalid_with_proposed_month_greater_than_december
    subject = Talk.new(kind: "beginner", title: "foo", presenter: "derp", email: "beep")
    assert subject.valid?
    subject.proposed_month = 13
    refute subject.valid?
  end

  def test_proposed_month_not_required
    subject = Talk.new(kind: "beginner", title: "foo", presenter: "derp", email: "beep")
    subject.proposed_month = nil
    assert subject.valid?
  end

  def test_no_proposed_month_means_no_proposed_date
    subject = Talk.new(kind: "beginner", title: "foo", presenter: "derp", email: "beep")
    subject.proposed_month = nil
    assert_nil subject.proposed_date
  end

  def test_proposed_date_is_first_tuesday_of_proposed_month_of_current_year
    Date.stub :today, Date.new(2014) do
      subject = Talk.new
      subject.proposed_month = 5
      assert_equal Date.new(2014, 5, 6), subject.proposed_date
    end
  end

end
