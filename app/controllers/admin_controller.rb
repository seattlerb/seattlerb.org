class AdminController < ApplicationController
  before_action :require_admin

  private

  def require_admin
    redirect_to "sessions/new" unless authenticated? and Current.user.admin?
  end
end
