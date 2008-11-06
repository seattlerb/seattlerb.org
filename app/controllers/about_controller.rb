class AboutController < ApplicationController
  def index
    @dudes    = Dude.all.sort_by{|d| d.name}
    @projects = Project.all.sort_by{|d| d.name}
  end
end
