class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return true if valid_url?(value)
    record.errors[attribute] << options.fetch(:message, 'is an invalid URL')
  end

  private

    def valid_url?(value)
      URI.parse(value).kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
      false
    end
end
