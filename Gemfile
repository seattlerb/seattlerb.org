# -*- ruby -*-

source "https://rubygems.org"

ruby "2.5.8"

gem "rails",                     "~> 4.2.11"
gem "sprockets",                 "~> 3.7.2" # TODO: temporary for security

gem "devise",                    "~> 4.8"
gem "httparty",                  "~> 0.13.3"
gem "jquery-rails",              "~> 4.0.3"
gem "rails_admin",               "~> 1.4"
gem "rake",                      "~> 12.3.3"
gem "twitter",                   "~> 5.14"
gem "uglifier",                  "~> 2.7.1"
gem "unicorn",                   "~> 4.8.3"

group :production do
  gem "pg",                      "~> 0.18"
  gem "rails_12factor",          "~> 0.0.3"
end

group :development, :test do
  gem "sqlite3",                 "= 1.3.11"
  gem "minitest-rails",          "~> 2.1.1"
  gem "ZenTest",                 "~> 4.9"
  gem "autotest-rails",          "~> 4.2.1"
  gem "letter_opener",           "~> 1.4.0"
  gem "pry",                     "~> 0.10.0"

  gem "therubyracer",            "~> 0.12" # required for local assets only?
end
