class AdminMailer < ActionMailer::Base
  def admin_notification(admins,talk)
    @talk = talk
    mail(:to => admins, :subject => "Seattle.rb Talk Notification", :from => "noreply@seattlerb.org")
  end
end