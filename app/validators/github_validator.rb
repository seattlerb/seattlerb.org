class GithubValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if valid_github_account?(value)
      record.errors[attribute] << (options[:message] || "username not found")
    end
  end

  def valid_github_account?(value)
    response = HTTParty.get("https://api.github.com/users/#{value}", :headers => {"User-Agent" => "seattle.rb"})

    p response
    response.headers["status"] == "404 Not Found"
  end
end
