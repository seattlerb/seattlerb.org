class EventController < ApplicationController
  def index
    @events = Event.next(3)
  end
end
