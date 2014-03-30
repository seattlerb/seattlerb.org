class AdminMailer < ActionMailer::Base
  def admin_notification(talk)
    @talk = talk
    @admins = User.find_all_by_talk_notification(true).map(&:email)
    mail(:to => @admins, :subject => "Seattle.rb Talk Notification", :from => "noreply@seattlerb.org")
  end
end
