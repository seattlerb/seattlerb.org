require "minitest_helper"

class AdminMailerTest < MiniTest::Rails::ActionMailer::TestCase

  def test_talk_notification_mail_fields
    talk     =            Talk.new(:kind              => "beginner",
                                   :title             => "Rails Security Vulnerabilities",
                                   :email             => "railsguru@aol.com",
                                   :presenter         => "Barack Obama",
                                   :description       => "Talk about Rails 4 vulnerability fixes.")
    
    admin_optin1    =  User.create!(:email             => "rubyadmin1@gmail.com",
                                   :password          => "password123",
                                   :talk_notification => true)

    admin_optin2    =  User.create!(:email             => "rubyadmin2@gmail.com",
                                   :password          => "password123",
                                   :talk_notification => true)

    admin_optout   =  User.create!(:email             => "rubyadmin_optout@gmail.com",
                                   :password          => "password123")
 
     admins = User.find_all_by_talk_notification(true).map(&:email)
     if !admins.empty? then
       mail = AdminMailer.admin_notification(admins,talk)
     end

    assert_match /noreply@seattlerb.org/, mail.from.first
    assert_match /Seattle.rb Talk Notification/, mail.subject
    assert mail.to.include?("rubyadmin1@gmail.com")
    assert mail.to.include?("rubyadmin2@gmail.com")
    assert !mail.to.include?("rubyadmin_optout@gmail.com")
    assert_match /beginner/, mail.encoded
    assert_match /Rails Security Vulnerabilities/, mail.encoded
    assert_match /railsguru@aol.com/, mail.encoded
    assert_match /Barack Obama/, mail.encoded 
    assert_match /Talk about Rails 4 vulnerability fixes./, mail.encoded
  end

end