class TalksController < ApplicationController
  before_filter :verify_password, :only => :create
  before_filter :set_title, :only => [:index, :create]

  def index
    talks
    recently_given
    @talk  = Talk.new
  end

  def create
    #spam catch to redirect - maybe the bots were ignoring the spam field
    redirect_to talks_url and return if talk_params[:special_talk_requests].present?

    @talk = Talk.new talk_params

    if @talk.save
      admins = Admin.where(talk_notification: true).map(&:email)
      AdminMailer.admin_notification(admins,@talk).deliver_later unless admins.empty?
      redirect_to talks_url, notice: 'Talk was successfully created.'
    else
      talks
      recently_given
      render action: "index"
    end
  end

  def show
    @disqus_shortname = "seattlerb"
    @talk = Talk.find params[:id]
  end

  def past
    @talks ||= Talk.older
  end

  private

  def set_title
    @title ||= "Talks"
  end

  def talks
    @talks ||= Talk.available
  end

  def recently_given
    @recent_talks ||= Talk.recently_given
  end

  def verify_password
    unless password_param.blank? then
      sleep rand(10) unless Rails.env.test?
      redirect_to root_path
    end
  end

  def password_param
    params.permit(:password).fetch(:password)
  end

  def talk_params
    params.require(:talk).permit(:title, :description, :presenter, :kind, :email, :spam, :special_talk_requests)
  end
end
