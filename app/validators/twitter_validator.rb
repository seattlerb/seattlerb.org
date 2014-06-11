class TwitterValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
      if HTTParty.get("https://www.twitter.com/#{value}").code == 404 then
      record.errors[attribute] << (options[:message] || "user isn't found" )
    end
  end
end