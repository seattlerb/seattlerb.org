class TalksController < ApplicationController
  before_filter :verify_password, :only => :create
  before_filter :set_title, :only => [:index, :create]

  def index
    talks
    @talk  = Talk.new
  end

  def create
    #spam catch to redirect - maybe the bots were ignoring the spam field
    redirect_to talks_url and return if talk_params[:special_talk_requests].present?

    @talk = Talk.new talk_params

    create_talk

    if @talk.persisted?
      redirect_to talks_url, notice: 'Talk was successfully created.'
    else
      talks
      render action: "index", alert: "Something went wrong."
    end
  end

  def show
    @disqus_shortname = "seattlerb"
    @talk = Talk.find params[:id]
  end

  def checklist
  end

  def past
    @talks ||= Talk.older
  end

  private

  def create_talk
    Talk.transaction do
      return false unless @talk.save

      admins = Admin.find_all_by_talk_notification(true).map(&:email)
      AdminMailer.admin_notification(admins, @talk).deliver unless admins.empty?
    end

    true
  rescue
    false
  end

  def set_title
    @title ||= "Talks"
  end

  def talks
    @talks ||= Talk.available
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
