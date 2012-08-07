class NewsletterController < ApplicationController
  def index
  end
  
  def subscribe
    ZenspiderSubscriber.subscribe!
    redirect_to join_us_path
  end

end
