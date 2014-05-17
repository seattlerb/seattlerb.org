class MembersController < ApplicationController
  # GET /members
  def index
    @members = Member.find_all_by_verified(true)
    @title = "Members"

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /Members/new
  def new
    @member = Member.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /Members
  def create
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
    params.require(:member).permit(:name, :email, :twitter, :github, :ruby_gems_id, :website, :bio)
  end
end