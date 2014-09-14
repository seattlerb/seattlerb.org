require "minitest_helper"

class AdminMailerTest < ActionMailer::TestCase

  def test_talk_notification_mail_fields
    talk = Talk.new(:kind              => "beginner",
                    :title             => "Rails Security Vulnerabilities",
                    :email             => "railsguru@aol.com",
                    :presenter         => "Barack Obama",
                    :description       => "Talk about Rails 4 vulnerability fixes.")

    mail = AdminMailer.admin_notification("rubyadmin@gmail.com",talk)

    assert_match /noreply@seattlerb.org/, mail.from.first
    assert_match /Seattle.rb Talk Notification/, mail.subject
    assert mail.to.include?("rubyadmin@gmail.com")
    assert_match /beginner/, mail.encoded
    assert_match /Rails Security Vulnerabilities/, mail.encoded
    assert_match /railsguru@aol.com/, mail.encoded
    assert_match /Barack Obama/, mail.encoded
    assert_match /Talk about Rails 4 vulnerability fixes./, mail.encoded
  end

end
