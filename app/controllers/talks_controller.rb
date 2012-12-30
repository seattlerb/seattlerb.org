class TalksController < ApplicationController
  before_filter :verify_password, :only => [:create, :update]

  def index
    @talks = Talk.all
    @talk  = Talk.new
  end

  def show
    @talk = Talk.find(params[:id])
  end

  def new
    @talk = Talk.new
  end

  def edit
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
  def verify_password
    unless params[:password] == "" then
      sleep rand(10) unless Rails.env.test?
      redirect_to root_path
    end
  end
end
