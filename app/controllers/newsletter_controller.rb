class NewsletterController < ApplicationController
  def index
  end

  def subscribe
    response = ZenspiderSubscriber.subscribe!(params[:subscribe])
    puts response.inspect
    redirect_to join_us_path
  end
end
