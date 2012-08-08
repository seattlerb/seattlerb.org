class DudesController < ApplicationController
  def index
    @dudes = Dude.scoped
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

end
