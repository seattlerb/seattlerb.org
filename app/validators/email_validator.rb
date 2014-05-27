class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /.@./
      record.errors[attribute] << (options[:message] || "invalid address")
    end
  end
end