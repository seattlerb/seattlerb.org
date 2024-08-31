require "minitest_helper"

class EventsControllerTest < ActionController::TestCase
  def setup
    begining = Date.parse("2024-01-01").beginning_of_year
    dates = 12.times.map { |i| Event.first_tues_month(begining + i.months) }
    @events = dates.map { |date| Event.create!(date: date) }
  end

  def test_index
    get :index
    assert_response :success
    assert_equal "text/calendar; charset=utf-8", response.content_type

    calendar = Icalendar::Calendar.parse(response.body).first
    events = calendar.events

    assert_equal 12, events.count
    assert_equal @events.map(&:date).sort, events.map(&:dtstart).map(&:to_date).sort
    assert_equal @events.map(&:date).map { |date| "Seattle.rb #{date.strftime("%B %Y")}" }, events.map(&:summary)
    assert_equal @events.map(&:id).map { |id| "https://seattlerb.org/?event_id=#{id}" }, events.map(&:url).map(&:to_s)
    assert_equal ["Seattle, WA"], events.map(&:location).uniq
    assert_equal ["PST", "PST", "PST", "PDT", "PDT", "PDT", "PDT", "PDT", "PDT", "PDT", "PST", "PST"], events.map(&:dtstart).map(&:zone)
  end
end
