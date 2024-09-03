class TwitterValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # no longer interacting with twitter...
  end
end
