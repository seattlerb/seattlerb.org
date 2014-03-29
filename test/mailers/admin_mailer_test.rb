require "minitest_helper"

class AdminMailerTest < MiniTest::Rails::ActionMailer::TestCase

  def test_mail_fields
    talk     =     Talk.new(:kind        => "beginner",
                            :title       => "Rails Security Vulnerabilities",
                            :email       => "railsguru@aol.com",
                            :presenter   => "Barack Obama",
                            :description => "Talk about Rails 4 vulnerability fixes.")
    
    admin    =  User.create!(:email      => "rubyadmin@gmail.com",
                             :password   => "password123")

    mail = AdminMailer.admin_notification(talk)

    assert_match /beginner/, mail.encoded
    assert_match /Rails Security Vulnerabilities/, mail.encoded
    assert_match /railsguru@aol.com/, mail.encoded
    assert_match /Barack Obama/, mail.encoded 
    assert_match /Talk about Rails 4 vulnerability fixes./, mail.encoded
    assert_match /rubyadmin@gmail.com/, mail.to.last
    assert_match /noreply@seattlerb.org/, mail.from.first
    assert_match /Seattle.rb Talk Notification/, mail.subject
  end

end