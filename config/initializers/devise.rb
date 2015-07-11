Devise.setup do |config|
  config.scoped_views = true

  config.mailer_sender = "noreply@seattlerb.org"

  require 'devise/orm/active_record'

  config.stretches = Rails.env.test? ? 1 : 10

  config.pepper = ENV["PEPPER"] || "6f21413efbe40de150e596d72f7a8c"

  # confirmable
  config.allow_unconfirmed_access_for = 1.days
  config.reconfirmable = true

  # rememberable
  config.remember_for = 12.weeks

  config.password_length = 4..128

  config.secret_key = if Rails.env.production?
    ENV.fetch("SECRET_KEY")
  else
    ENV.fetch("SECRET_KEY", "dc2d7e3da039a322d8028134c256f97eb18e8c1f24829be0238a11e95ce82f771a94124997d9d11341a3bd62717e7a4239ae0e7f0e014f2ed5e95c586fadf723")
  end
end
