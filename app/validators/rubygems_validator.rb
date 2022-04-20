require 'net/http'
require 'uri'

class RubygemsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    uri = URI("https://rubygems.org/api/v1/owners/#{value}/gems.json")

    unless Net::HTTPSuccess === Net::HTTP.get_response(uri) then
      record.errors.add attribute, options.fetch(:message, "user isn't found")
    end
  end
end
