# -*- ruby -*-

source "https://rubygems.org"

# heroku uses bundler 1.0.7 so this isn't supported, but it is the
# version we need to use:
# ruby "1.9.2"

gem "rake",                      "~> 0.9.0"
gem "rails",                     "~> 3.2.17"
gem "jquery-rails",              "~> 3.1.0"
gem "httparty",                  "~> 0.8.0"
gem "rails_admin",               "~> 0.4.9"
gem "devise",                    "~> 2.1.0"
gem "strong_parameters",         "~> 0.2.3"
gem "twitter",                   "~> 5.0.0"

group :production do
  gem "pg",                      "~> 0.12.0"
end

group :assets do
  gem "uglifier",                "~> 1.2.0"
end

group :development, :test do
  gem "heroku",                  "~> 2.19"
  gem "sqlite3",                 "~> 1.3.0"
  gem "minitest-rails",          "~> 0.3"
  gem "ZenTest",                 "~> 4.9"
  gem "autotest-rails",          "~> 4.1.2"
end
