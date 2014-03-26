class EventController < ApplicationController
  def index
    @events = Event.next(3) #not implemented yet
  end
end
