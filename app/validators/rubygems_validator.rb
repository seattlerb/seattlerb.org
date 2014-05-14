class RubygemsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      MultiJson.load(HTTParty.get("https://rubygems.org/api/v1/owners/#{value}/gems.json").body)
    rescue MultiJson::ParseError => e          
      record.errors[attribute] << (options[:message] || "owner isn't found" )
    end
  end
end