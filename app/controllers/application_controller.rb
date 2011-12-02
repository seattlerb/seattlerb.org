class ApplicationController < ActionController::Base
  # filter_parameter_logging :password
  helper :all
  protect_from_forgery
end
