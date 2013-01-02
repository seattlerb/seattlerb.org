class NewsletterController < ApplicationController
  def subscribe
    response = ZenspiderSubscriber.subscribe!(params[:subscribe])
    redirect_to join_us_path
  end
end
