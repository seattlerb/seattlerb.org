class NewsletterController < ApplicationController
  def subscribe
    ZenspiderSubscriber.subscribe!(subscribe_params)
    redirect_to join_us_path
  end

  private

  def subscribe_params
    params.require(:subscribe).permit({:person => :email}, :subscribe_to_discussion, :subscribe_to_jobs)
  end
end
