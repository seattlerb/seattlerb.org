class AboutController < ApplicationController
  before_filter :get_event, only: [:index, :join_us]
  def index
    @title = "Home"
  end

  def people
    @people = Member.order('featured desc, name asc')
  end

  def projects
    @projects = Project.find(:all).sort_by { |p| p.name.downcase }
  end

  def join_us
  end

  private

  def get_event
    @event = Event.next
  end
end
