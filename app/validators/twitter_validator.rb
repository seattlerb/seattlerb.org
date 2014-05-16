class TwitterValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
    begin
      client.user(value)
    rescue Exception => e
      record.errors[attribute] << (options[:message] || "user isn't found" )
    end
  end
end