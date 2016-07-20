class MembersController < ApplicationController
  before_action :verify_member, only: [:edit, :update, :show]

  def index
    @members = Member.verified.all
    @title = "Members"
  end

  def update
    if @member.update(member_params)
      redirect_to member_path, notice: 'Updated successfully'
    else
      render action: "edit"
    end
  end

  def show
    @books = @member.books
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :twitter, :github, :ruby_gems_id, :website, :bio)
  end

  def verify_member
    @member = Member.find params[:id]
    redirect_to members_path, notice: 'You can only modify your own profile.' unless @member == current_member
  end
end
