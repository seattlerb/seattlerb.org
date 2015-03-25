Devise.setup do |config|
  config.mailer_sender = "noreply@seattlerb.org"

  require 'devise/orm/active_record'

  config.stretches = Rails.env.test? ? 1 : 10

  config.pepper = ENV["PEPPER"] || "6f21413efbe40de150e596d72f7a8c"

  # confirmable
  config.allow_unconfirmed_access_for = 1.days
  config.reconfirmable = true

  # rememberable
  config.remember_for = 12.weeks

  config.secret_key = '966d17ce12454589478a70cffa56b8407e59acae8cc8aed66e1bb05b96527c38ccf2fd87e8337ad7430d9bd5fcbcf618f4cefb26b56f0d142398855084323483'
end
