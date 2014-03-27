require "minitest_helper"

class AdminMailerTest < MiniTest::Rails::ActionMailer::TestCase
  def mail_has_fields
    talk     =     Talk.new(:kind        => "beginner",
                            :title       => "Rails Security Vulnerabilities",
                            :email       => "railsguru@aol.com",
                            :presenter   => "Barack Obama",
                            :description => "Talk about Rails 4 vulnerability fixes.")
    
    admin    =  User.create(:email       => "rubyadmin@gmail.com")

    mail = AdminMailer.admin_notification(talk)

    assert_matches "beginner", mail.encoded
    assert_matches "Rails Security Vulnerabilities", mail.encoded
    assert_matches "railsguru@aol.com", mail.encoded
    assert_matches "Barack Obama", mail.encoded 
    assert_matches "Talk about Rails 4 vulnerability fixes.", mail.encoded
    assert_matches "rubyadmin@gmail.com", mail.to.first
    assert_matches "noreply@seattlerb.org", mail.from
    assert_matches "Seattle.rb Talk Notification", mail.subject
  end
end