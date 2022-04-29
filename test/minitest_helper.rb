ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require "minitest/autorun"
require "rails/test_help"
require "minitest/rails"
require "minitest/pride"

class ActiveSupport::TestCase
end

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
