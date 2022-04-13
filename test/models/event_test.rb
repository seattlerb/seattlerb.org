require "minitest_helper"

class EventTest < ActiveSupport::TestCase
  def test_valid
    e = Event.new(:date => '2014-03-26')
    assert e.valid?
  end

  def test_unique
    date = Event.first_tues_next_month

    # bullshit a race condition
    e1 = Event.new date: date # unsaved
    e2 = Event.next           # saved

    assert_predicate e2, :valid?
    refute_predicate e1, :valid?

    exp = {:date=>["has already been taken"]}

    assert_equal exp, e1.errors.messages
  end

  def test_valid_no_date
    event = Event.new
    refute event.valid?
  end

  def test_next_event_present
    e1 = Event.create!(:date => Date.today + 1.week)
    e2 = Event.next
    assert_equal e1, e2
  end

  def test_next_create
    assert_difference 'Event.count', 1 do
      e = Event.next
      assert_equal e.date, Event.first_tues_next_month
    end
  end

  def test_first_tues_month
    assert_equal Event.first_tues_month(Date.new(2014, 1, 31) + 1.month), Date.new(2014, 2, 4)
    assert_equal Event.first_tues_month(Date.new(2014, 12 ,31) + 1.month), Date.new(2015, 1, 6)
  end
end
