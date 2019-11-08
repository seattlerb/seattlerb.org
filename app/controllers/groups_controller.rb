class GroupsController < ApplicationController

  def index
    @groups = Group.all
    @title = "Study Groups"
  end

  def new
    @group = Group.new
    @title = "Study Groups"
  end

  def create
    #spam catch to redirect - maybe the bots were ignoring the spam field
    redirect_to groups_url and return if group_params[:username].present?
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html {redirect_to groups_path, notice: 'Thank you for listing the study group.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def show
    @title = "Study Groups"
    @group = Group.find params[:id]
  end

  private

  def group_params
    params.require(:group).permit(:book, :active, :github, :username)
  end

end
