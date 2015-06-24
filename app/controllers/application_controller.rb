class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # filter_parameter_logging :password
  helper :all
  protect_from_forgery

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:username, :name, :email, :twitter, :github, :ruby_gems_id, :website, :bio)
  end
end
