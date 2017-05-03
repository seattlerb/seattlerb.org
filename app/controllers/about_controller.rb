class AboutController < ApplicationController
  before_filter :get_event, only: [:index, :join_us]
  def index
    @title = "Home"
  end

  def projects
    @projects = Project.includes(:members).all.sort_by { |p| p.name.downcase }
  end

  def join_us
  end

  def values
  end

  private

  def get_event
    @event = Event.next
  end
end
