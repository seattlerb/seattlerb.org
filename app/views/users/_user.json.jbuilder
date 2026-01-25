json.extract! user, :id, :email_address, :name, :bio, :website, :rubygems_name, :github_name, :verified, :created_at, :updated_at
json.url user_url(user, format: :json)
