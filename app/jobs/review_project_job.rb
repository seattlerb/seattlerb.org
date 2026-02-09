class ReviewProjectJob < ApplicationJob
  def self.queue_all(ps=Project.all) = super ps.map { |p| new p }

  def perform project
    project.reviews.where(field: :url).destroy_all
    check_url project, :url, project.url
    project
  rescue => e
    project.reviews.create!(field: :url,
                            url: project.url,
                            message: e.message)
  end
end
