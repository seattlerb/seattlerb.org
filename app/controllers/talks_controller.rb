class TalksController < ApplicationController
  def index
    @talks = Talk.all
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
    @talk.kind = @talk.kind.to_sym

    if @talk.save
      redirect_to @talk, notice: 'Talk was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @talk = Talk.find(params[:id])
    params[:talk][:kind] = params[:talk][:kind].to_sym

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
end
