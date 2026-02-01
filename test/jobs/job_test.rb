require "test_helper"

class JobTest < ActiveJob::TestCase
  def job
    return @job if defined? @job

    klass = self.class.name.delete_suffix "Test"
    @job = klass.constantize.new
  end
end
