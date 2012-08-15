class DudesController < ApplicationController
  before_filter :basic_auth if Rails.env.production?
  def index
    @dudes = Dude.order('name asc')
  end

  def new
    @dude = Dude.new
  end

  def create
    @dude = Dude.create(params[:dude])
    if @dude.save
      redirect_to dudes_path
    else
      render :new
    end
  end

  def edit
    @dude = Dude.find(params[:id])
  end

  def update
    @dude = Dude.find(params[:id])
    if @dude.update_attributes(params[:dude])
      redirect_to dudes_path
    else
      render :edit
    end
  end

  def destroy
    @dude = Dude.find(params[:id])
    @dude.destroy
    redirect_to dudes_path
  end
end
