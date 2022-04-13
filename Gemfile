# -*- ruby -*-

source "https://rubygems.org"

ruby "~> 2.7"

gem "rails",                     "~> 5.2.0"

gem "bootsnap",                  "~> 1.11"
gem "devise",                    "~> 4.8"
gem "httparty",                  "~> 0.18"
gem "rails_admin",               "~> 1.0"
gem "rake",                      "~> 13.0"
gem "twitter",                   "~> 5.14"
gem "uglifier",                  "~> 2.7.1"
gem "unicorn",                   "~> 4.9.0"

group :production do
  gem "pg",                      "~> 1.0"
  gem "rails_12factor",          "~> 0.0.3"
end

group :development, :test do
  gem "sqlite3",                 "~> 1.4"
  gem "minitest",                "~> 5.14"
  gem "minitest-rails",          "~> 5.2"
  gem "ZenTest",                 "~> 4.9"
  gem "autotest-rails",          "~> 4.2.1", require: false
  gem "letter_opener",           "~> 1.4.0"
  gem "pry",                     "~> 0.13.0"
  gem "pry-byebug",              "~> 3.9"
  gem "rails-controller-testing", "~> 1.0"

  gem "mini_racer",              "~> 0.4" # required for local assets only?
end
