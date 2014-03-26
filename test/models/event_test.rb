require "minitest_helper"

class EventTest < MiniTest::Rails::ActiveSupport::TestCase
  def test_valid
    event = Event.new(:date => '2014-03-26')
    assert event.valid?
  end

  def test_invalid
    event = Event.new
    refute event.valid?
  end

  def test_first_tues_month
    assert_equal Event.first_tues_month(Date.new(2014,1,12)), Date.new(2014,1,7)
    assert_equal Event.first_tues_month(Date.new(2014,2,18)), Date.new(2014,2,4)
    assert_equal Event.first_tues_month(Date.new(2014,3,9)), Date.new(2014,3,4)
    assert_equal Event.first_tues_month(Date.new(2014,4,28)), Date.new(2014,4,1)
    assert_equal Event.first_tues_month(Date.new(2014,5,12)), Date.new(2014,5,6)
    assert_equal Event.first_tues_month(Date.new(2014,6,5)), Date.new(2014,6,3)
    assert_equal Event.first_tues_month(Date.new(2014,7,2)), Date.new(2014,7,1)
    assert_equal Event.first_tues_month(Date.new(2014,8,7)), Date.new(2014,8,5)
    assert_equal Event.first_tues_month(Date.new(2014,9,1)), Date.new(2014,9,2)
    assert_equal Event.first_tues_month(Date.new(2014,10,29)), Date.new(2014,10,7)
    assert_equal Event.first_tues_month(Date.new(2014,11,12)), Date.new(2014,11,4)
    assert_equal Event.first_tues_month(Date.new(2014,12,24)), Date.new(2014,12,2)

    assert_equal Event.first_tues_month(Date.new(2014,12,4) + 1.month), Date.new(2015,1,6)
  end
end
