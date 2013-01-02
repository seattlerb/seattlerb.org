class AboutController < ApplicationController
  def index
    @title = "Home"
  end

  def people
    @people = Dude.order('featured desc, name asc')
  end

  def projects
    @projects = Project.find(:all).sort_by { |p| p.name.downcase }
  end
end
