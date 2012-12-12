class TalksController < ApplicationController
  SECRET = "gorby"

  before_filter :verify_secret, :only => [:create, :update]

  def index
    @talks = Talk.all
  end

  def show
    @talk = Talk.find(params[:id])
  end

  def new
    @secret = SECRET
    @talk = Talk.new
  end

  def edit
    @secret = SECRET
    @talk = Talk.find(params[:id])
  end

  def create
    @talk = Talk.new(params[:talk])

    if @talk.save
      redirect_to @talk, notice: 'Talk was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @talk = Talk.find(params[:id])

    if @talk.update_attributes(params[:talk])
      redirect_to @talk, notice: 'Talk was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @talk = Talk.find(params[:id])
    @talk.destroy

    redirect_to talks_url
  end

  private
  def verify_secret
    unless params[:secret] == SECRET then
      redirect_to root_path
    end
  end
end
