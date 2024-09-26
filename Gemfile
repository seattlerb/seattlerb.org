# -*- ruby -*-

source "https://rubygems.org"

ruby "~> 3.3.0"

gem "rails",                     "~> 7.2.0"

gem "bootsnap",                  "~> 1.11"
gem "devise",                    "~> 4.8"
gem "rails_admin",               "~> 3.0"
gem "rake",                      "~> 13.0"
gem "unicorn",                   "~> 6.0"
gem "sprockets",                 "~> 3.7"

# noise dependencies:

gem "csv"                                 # for rails_admin
gem "logger"                              # for activesupport, le sigh
gem "ostruct"                             # for json, le sigh
gem "sassc-rails",               "~> 2.1" # for rails_admin?
gem "fiddle"                              # for pry-byebug, loaded in dev env

group :production do
  gem "pg",                      "~> 1.0"
end

group :development, :test do
  gem "sqlite3",                 "~> 2.0"
  gem "minitest",                "~> 5.14"
  gem "minitest-rails",          "~> 7.1.0"
  gem "ZenTest",                 "~> 4.9", require: false
  gem "autotest-rails",          "~> 4.2.1", require: false
  gem "pry",                     "~> 0.13", require: false
  gem "pry-byebug",              "~> 3.9", require: false
  gem "rails-controller-testing", "~> 1.0"
end
