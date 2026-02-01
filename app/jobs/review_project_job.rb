class ReviewProjectJob < ApplicationJob
  queue_as :default

  def perform project
    check_url project, :url, project.url
  end
end
