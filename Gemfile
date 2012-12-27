source "http://rubygems.org"

gem "rake"
gem "rails", "3.1.3"
gem "jquery-rails"
gem "httparty"
group :production do
  gem "pg"
end

group :assets do
  gem "sass-rails",   "~> 3.1.5"
  gem "coffee-rails", "~> 3.1.1"
  gem "uglifier", ">= 1.0.3"
  gem "twitter-bootstrap-rails"
end

group :development, :test do
  gem "heroku"
  gem "sqlite3"
  gem "rspec-rails"
end

group :test, :development do
  gem "minitest-rails"
  gem "ZenTest"
  gem "autotest-fsevent"
end