class AboutController < ApplicationController
  def index
    @dudes    = Dude.all.sort_by{|d| d.projects.length}.reverse
    @projects = Project.all.sort_by{|d| d.name.downcase}
  end
  
  def people
    @dudes = Dude.scoped
  end
  
  def projects
    @projects = Project.order('name')
  end
  
  def join_us
    
  end
end
