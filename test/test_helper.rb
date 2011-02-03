ENV["RAILS_ENV"] = "test"
require "config/environment"
require 'test_help'

class ActiveSupport::TestCase
  self.use_instantiated_fixtures  = false
  self.use_transactional_fixtures = true

  fixtures :all
end
