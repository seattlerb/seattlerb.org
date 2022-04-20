class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /.@./
      record.errors.add attribute, options.fetch(:message, "invalid address")
    end
  end
end
