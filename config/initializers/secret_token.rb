# Be sure to restart your server when you modify this file.

SeattlerbOrg::Application.config.secret_key_base = if Rails.env.production?
  ENV.fetch("SECRET_KEY_BASE")
else
  ENV.fetch("SECRET_KEY_BASE", "b52f1f42559de17bf01d0c3a4168e65f71c4d70e73d04582820679c525bbc52b9beb76a84a6dc2d5de5775eb7be336e9f784a1dbe5badefbfeb3997c6668eac4")
end
