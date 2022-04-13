# -*- ruby -*-

source "https://rubygems.org"

ruby "~> 2.7"

gem "rails",                     "~> 5.0.7"

gem "devise",                    "~> 4.8"
gem "httparty",                  "~> 0.13.3"
gem "rails_admin",               "~> 1.0"
gem "rake",                      "~> 13.0"
gem "twitter",                   "~> 5.14"
gem "uglifier",                  "~> 2.7.1"
gem "unicorn",                   "~> 4.8.3"

group :production do
  gem "pg",                      "~> 0.21"
  gem "rails_12factor",          "~> 0.0.3"
end

group :development, :test do
  gem "sqlite3",                 "= 1.3.11" # temporary -- won't build on arm64?
  gem "minitest",                "~> 5.10.0"
  gem "minitest-rails",          "~> 5.0.0"
  gem "ZenTest",                 "~> 4.9"
  gem "autotest-rails",          "~> 4.2.1", require: false
  gem "letter_opener",           "~> 1.4.0"
  gem "pry",                     "~> 0.13.0"
  gem "pry-byebug",              "~> 3.9"
  gem "rails-controller-testing", "~> 1.0"

  gem "mini_racer",              "~> 0.4" # required for local assets only?
end
