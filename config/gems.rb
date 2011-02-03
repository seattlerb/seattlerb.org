require "rubygems"
require "isolate"

Isolate.now! do
  gem "rails", "= 2.3.3"

  environment :development do
    gem "heroku"
    gem "sqlite3"
  end

  environment :test do
    gem "minitest"
  end
end
