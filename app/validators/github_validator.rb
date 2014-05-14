class GithubValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if HTTParty.get("https://api.github.com/users/#{value}", :headers => {"User-Agent" => "seattle.rb"})["html_url"] == nil
      record.errors[attribute] << (options[:message] || "username not found")
    end
  end
end