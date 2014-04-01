require "minitest_helper"

class AdminMailerTest < MiniTest::Rails::ActionMailer::TestCase

  def test_talk_notification_mail_fields
    talk     =            Talk.new(:kind              => "beginner",
                                   :title             => "Rails Security Vulnerabilities",
                                   :email             => "railsguru@aol.com",
                                   :presenter         => "Barack Obama",
                                   :description       => "Talk about Rails 4 vulnerability fixes.")
    
    admin_optin    =  User.create!(:email             => "rubyadmin@gmail.com",
                                   :password          => "password123",
                                   :talk_notification => true)
 
    mail = AdminMailer.admin_notification(admin_optin.email,talk)

    assert_match /beginner/, mail.encoded
    assert_match /Rails Security Vulnerabilities/, mail.encoded
    assert_match /railsguru@aol.com/, mail.encoded
    assert_match /Barack Obama/, mail.encoded 
    assert_match /Talk about Rails 4 vulnerability fixes./, mail.encoded
    assert_match /rubyadmin@gmail.com/, mail.to.last
    assert_match /noreply@seattlerb.org/, mail.from.first
    assert_match /Seattle.rb Talk Notification/, mail.subject
  end

  def test_talk_notification_opt_out
    talk     =            Talk.new(:kind              => "beginner",
                                   :title             => "Rails Security Vulnerabilities",
                                   :email             => "railsguru@aol.com",
                                   :presenter         => "Barack Obama",
                                   :description       => "Talk about Rails 4 vulnerability fixes.")

    admin_optout   =  User.create!(:email             => "rubyadmin_optout@gmail.com",
                                   :password          => "password123")

    admins = User.find_all_by_talk_notification(true).map(&:email)
    if !admins.empty? then
      AdminMailer.admin_notification(admins,talk).deliver
    end    

    admins_all = User.all.map(&:email)
    admins_talk_true = User.find_all_by_talk_notification(true).map(&:email)

    assert_match /rubyadmin_optout@gmail.com/, admins_all.last
    assert admins_talk_true.empty?
    assert admins.empty?
  end

end