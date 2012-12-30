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
end
