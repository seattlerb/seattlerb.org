# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
SeattlerbOrg::Application.config.secret_token = if Rails.env.production?
  ENV.fetch("SECRET_TOKEN")
else
  ENV.fetch("SECRET_TOKEN", "81f3f7ae6f5e7ab84987dc9d6f7297e49fea643de945e92985a9eefc27502c25564cf6de29e5c160eaba8df4bbc27a5227ac2a90a16000e04461105560f6fdf6")
end

SeattlerbOrg::Application.config.secret_key_base = if Rails.env.production?
  ENV.fetch("SECRET_KEY_BASE")
else
  ENV.fetch("SECRET_KEY_BASE", "b52f1f42559de17bf01d0c3a4168e65f71c4d70e73d04582820679c525bbc52b9beb76a84a6dc2d5de5775eb7be336e9f784a1dbe5badefbfeb3997c6668eac4")
end
