class TwitterValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    uri = URI("https://www.twitter.com/#{value}")
    res = Net::HTTP.get_response(uri)

    if res.code != "200" then
      record.errors.add attribute, (options[:message] || "user isn't found" )
    end
  end
end
