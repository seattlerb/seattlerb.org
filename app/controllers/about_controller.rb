class AboutController < ApplicationController
  def index
    @title = "Home"
  end
  
  def people
    @people = Dude.order('featured desc, name asc')
  end
  
  def projects
    @projects = Project.order('name')
  end
  
  def join_us
  end
end
