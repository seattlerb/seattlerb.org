class ApplicationJob < ActiveJob::Base
  retry_on Net::OpenTimeout, Timeout::Error, wait: :polynomially_longer, attempts: 10

  def self.clear_all      = SolidQueue::Job.where(class_name: name).destroy_all
  def self.standard_delay = 0

  def self.queue_all jobs
    ActiveJob.perform_all_later Array(jobs).map { |job| job.set(wait: standard_delay) }
  end

  def try_url url, msg=nil
    msg ||= "Trying url: %s" % [url]
    Rails.logger.info msg
    URI.parse(url).read(open_timeout: 3, read_timeout: 5)
  end

  def check_url model, field, url
    msg = "Reviewing %s#%d url: %s" % [model.class, model.id, url]
    try_url url, msg
  end
end
