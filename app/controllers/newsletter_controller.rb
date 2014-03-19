class NewsletterController < ApplicationController
  def subscribe
    ZenspiderSubscriber.subscribe!(subscribe_params)
    redirect_to join_us_path
  end

  private

  def subscribe_params
    params.permit(:person, :subscribe_to_discussion, :subscribe_to_jobs)
  end
end
