class TalksController < ApplicationController
  before_filter :verify_password, :only => :create
  before_filter :set_title, :only => [:index, :create]

  def new
    @talk = Talk.new
    render :form
  end

  def show
    @talk = Talk.find(params[:id])
  end

  def index
    talks
    # class method for setting past talks
    @talk  = Talk.new

  end

  def create
    #spam catch to redirect - maybe the bots were ignoring the spam field
    redirect_to talks_url and return if params['talk']['special_talk_requests'].present?

    @talk = Talk.new(params[:talk])

    if @talk.save
      # TODO:   send email here
      redirect_to talks_url, notice: 'Talk was successfully created.'
    else
      talks
      render action: "index", notice: 'There was a problem saving your talk.'
    end
  end

  def checklist
  end

  private

  def set_title
    @title ||= "Talks"
  end

  def talks
    @talks ||= Talk.available
  end

  def verify_password
    unless params[:password] == "" then
      sleep rand(10) unless Rails.env.test?
      redirect_to root_path
    end
  end
end
