class GithubValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    uri = URI("https://api.github.com/users/#{value}")
    res = Net::HTTP.get_response(uri)

    if res.code != "200" then
      record.errors.add attribute, (options[:message] || "username %p not found (%p)" % [value, res.code])
    end
  end
end
