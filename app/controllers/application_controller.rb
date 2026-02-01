class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private
  def check_job_name name
    @jobs ||= begin
                Rails.application.eager_load!
                ApplicationJob.descendants.map(&:name).sort
              end

    raise "nah: %p not in %p" % [name, @jobs] unless @jobs.include? name

    name.safe_constantize
  end
end
