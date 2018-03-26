# -*- ruby -*-

source "https://rubygems.org"

ruby "2.3.5"

gem "rails",                     "~> 4.2.10"

gem "devise",                    "~> 3.4.1"
gem "httparty",                  "~> 0.13.3"
gem "jquery-rails",              "~> 4.0.3"
gem "rails_admin",               "~> 1.0"
gem "rake",                      "~> 10.4.2"
gem "twitter",                   "~> 5.14.0"
gem "uglifier",                  "~> 2.7.1"
gem "unicorn",                   "~> 4.8.3"

group :production do
  gem "pg",                      "~> 0.18.1"
  gem "rails_12factor"
end

group :development, :test do
  gem "sqlite3",                 "~> 1.3.0"
  gem "minitest-rails",          "~> 2.1.1"
  gem "ZenTest",                 "~> 4.9"
  gem "autotest-rails",          "~> 4.2.1"
  gem "letter_opener"
  gem "pry"
end
