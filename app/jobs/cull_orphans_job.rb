class CullOrphansJob < ApplicationJob
  def self.queue_all = super new

  def perform
    Project
      .orphans
      .tap { |os| Rails.logger.info "Deleting projects: %p" % [os.map(&:name)] }
      .destroy_all
  end
end
