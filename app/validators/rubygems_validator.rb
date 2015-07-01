class RubygemsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    url = "https://rubygems.org/api/v1/owners/#{value}/gems.json"
    response = JSON.parse(HTTParty.get(url).response.body)

    if response.include?("status") && response["status"] == "404"
      record.errors[attribute] << "user isn't found"
    end
  end
end
