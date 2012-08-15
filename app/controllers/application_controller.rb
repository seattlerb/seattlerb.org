class ApplicationController < ActionController::Base
  # filter_parameter_logging :password
  helper :all
  protect_from_forgery

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      (username.downcase == "admin") && (password == ENV["SEATTLERB_ADMIN_PASSWORD"])
    end
  end
end
