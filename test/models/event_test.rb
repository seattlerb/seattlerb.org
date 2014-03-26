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

  def test_next
    event = Event.create!(:date => Date.today)
    assert_equal Event.next, event
  end
end
