class EventsController < ApplicationController
  def index
    @events = Event.all

    respond_to do |format|
      format.ics {
        render plain: Calendar.new(@events).to_ical
      }
    end
  end
end
