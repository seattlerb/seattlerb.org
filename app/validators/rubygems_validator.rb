class RubygemsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if HTTParty.get("https://rubygems.org/api/v1/owners/#{value}/gems.json").response.body == "Owner could not be found." then
      record.errors[attribute] << (options[:message] || "user isn't found" )
    end
  end
end