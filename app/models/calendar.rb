require "tzinfo"
require "icalendar"
require "icalendar/tzinfo"

class Calendar
  def initialize(events)
    @events = events
  end

  def publish
    calendar = Icalendar::Calendar.new

    calendar.timezone do |timezone|
      timezone.tzid = timezone_identifier
    end

    @events.each do |event|
      calendar.event do |e|
        e.dtstart     = ical_time(DateTime.parse("#{event.date} 19:00:00"))
        e.dtend       = ical_time(DateTime.parse("#{event.date} 21:00:00"))
        e.summary     = "Seattle.rb #{event.date.strftime("%B %Y")}"
        e.description = "Seattle.rb Event on #{event.date.strftime("%A, %B %d, %Y")}"
        e.location    = "Seattle, WA"
        e.url         = "https://seattlerb.org/?event_id=#{event.id}"
      end
    end

    calendar.publish
  end

  def to_ical
    publish.to_ical
  end

  private

  def timezone_identifier
    "America/Los_Angeles"
  end

  def timezone
    @timezone ||= TZInfo::Timezone.get(timezone_identifier)
  end

  def ical_timezone
    timezone.ical_timezone(timezone.now)
  end

  def ical_time(datetime)
    Icalendar::Values::DateTime.new(datetime, tzid: timezone_identifier)
  end
end
