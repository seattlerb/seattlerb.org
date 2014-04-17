require "minitest_helper"

class EventTest < MiniTest::Rails::ActiveSupport::TestCase
  def test_valid
    e = Event.new(:date => '2014-03-26')
    assert e.valid?
  end

  def test_invalid
    event = Event.new
    refute event.valid?
  end

  def test_first_tues_month
    assert_equal(Event.first_tues_month(Date.new(2014,1,31) + 1.month), Date.new(2014,2,4))
    assert_equal(Event.first_tues_month(Date.new(2014,12,31) + 1.month), Date.new(2015,1,6))
  end
end
