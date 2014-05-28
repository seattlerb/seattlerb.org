class MembersController < ApplicationController
  def index
    @members = Member.verified.all
    @title = "Members"
  end

  def new
    @member = Member.new
  end

  def create
    #spam catch to redirect - maybe the bots were ignoring the spam field
    redirect_to members_url and return if member_params[:username].present?
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to members_path, notice: 'Thank you for submitting, we will validate your request.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :twitter, :github, :ruby_gems_id, :website, :bio, :username)
  end
end