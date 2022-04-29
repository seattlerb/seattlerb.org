ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require "minitest/autorun"
require "rails/test_help"
require "minitest/rails"
require "minitest/pride"

# Uncomment if you want Capybara in accceptance/integration tests
# require "minitest/rails/capybara"

# Uncomment if you want awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

# Do you want all existing Rails tests to use MiniTest::Rails?
# Comment out the following and either:
# A) Change the require on the existing tests to `require "minitest_helper"`
# B) Require this file's code in test_helper.rb

# MiniTest::Rails.override_testunit!
module FakeNetwork
  def good
    obj = Object.new
    def obj.code
      "200"
    end
    obj
  end

  def bad
    obj = Object.new
    def obj.code
      "404"
    end
    obj
  end

  def good_net_response
    Net::HTTP.stub(:get_response, good) do
      yield
    end
  end

  def bad_net_response
    Net::HTTP.stub(:get_response, bad) do
      yield
    end
  end
end

class ActionController::TestCase
  include Devise::Test::ControllerHelpers
  include FakeNetwork
end
