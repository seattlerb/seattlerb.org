class MembersController < ApplicationController
  def index
    @members = Member.verified.all.sort_by { |m| m.name.split.rotate(1) }
    @title = "Members"
  end

  def edit
    @member = Member.find params[:id]
  end

  def update
    @member = current_member
    if @member.update(member_params)
      redirect_to member_path, notice: 'Updated successfully'
    else
      render action: "edit"
    end
  end

  def show
    @member = Member.find params[:id]
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :twitter, :github, :ruby_gems_id, :website, :bio)
  end
end
