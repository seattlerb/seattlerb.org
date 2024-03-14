# -*- ruby -*-

source "https://rubygems.org"

ruby "~> 3.1.0"

gem "rails",                     "~> 7.0.8"

gem "bootsnap",                  "~> 1.11"
gem "devise",                    "~> 4.8"
gem "rails_admin",               "~> 3.0"
gem "rake",                      "~> 13.0"
gem "sassc-rails",               "~> 2.1" # for rails_admin?
gem "twitter",                   "~> 7.0"
gem "unicorn",                   "~> 6.0"

group :production do
  gem "pg",                      "~> 1.0"
end

group :development, :test do
  gem "sqlite3",                 "~> 1.4"
  gem "minitest",                "~> 5.14"
  gem "minitest-rails",          "~> 7.0.0"
  gem "ZenTest",                 "~> 4.9", require: false
  gem "autotest-rails",          "~> 4.2.1", require: false
  gem "pry",                     "~> 0.13", require: false
  gem "pry-byebug",              "~> 3.9", require: false
  gem "rails-controller-testing", "~> 1.0"
end
