ENV["PARALLEL_WORKERS"] = "1" if ENV["COV"]
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require_relative "test_helpers/session_test_helper"

if ENV["COV"] then
  warn "Measuring coverage. Parallelism disabled."
  require "simplecov"
  SimpleCov.start # TODO: { add_filter %p }
  Rails.application.eager_load!
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

# sabotage open-uri for testing
module OpenURI
  module OpenRead
    def read options = {}
      raise "NO! %p : %p" % [self, options]
    end
  end
end
