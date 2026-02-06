class Admin::DashboardController < AdminController
  def index
    @reviews = Review.all
  end

  def update
    raise "nope"
  end

  def run
    klass = check_job_name params.expect(:name)

    Rails.logger.info "Running job named %s" % [klass]

    klass.queue_all

    redirect_to admin_dashboard_path
  end

  def cancel
    klass = check_job_name params.expect(:name)

    Rails.logger.info "Canceling jobs for %s" % [klass]

    klass.clear_all

    redirect_to admin_dashboard_path
  end

  def pause
    name = params.expect(:name)

    SolidQueue::Queue.find_by_name(name).pause

    redirect_to admin_dashboard_path
  end

  def resume
    name = params.expect(:name)

    SolidQueue::Queue.find_by_name(name).resume

    redirect_to admin_dashboard_path
  end

  def switch
    location = Location.find params.expect(:location_id)

    Current.location = location

    redirect_to admin_dashboard_path, notice: "Location was successfully changed."
  end
end
