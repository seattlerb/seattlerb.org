class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless URI.parse(value).kind_of?(URI::HTTP)
      record.errors[attribute] << (options[:message] || "is an invalid URL")
    end   
  end
end