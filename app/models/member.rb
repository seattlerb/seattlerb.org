class Member < ActiveRecord::Base
  habtm :projects, :join_table => :affiliations

  validates_presence_of :name

  validates :email,        :email => true,    :allow_blank => true
  validates :twitter,      :twitter => true,  :allow_blank => true
  validates :github,       :github => true,   :allow_blank => true
  validates :ruby_gems_id, :rubygems => true, :allow_blank => true
  validates :website,      :url => true,      :allow_blank => true

  scope :featured, where(featured: true)
  scope :regular, where(featured: false)
  scope :verified, where(verified: true)

  before_save :set_avatar, if: Proc.new { |user|
    user.respond_to?(:twitter_changed?) and user.twitter_changed?
  }

  def bio
    bio = self['bio']
    bio.present? ? bio : "..."
  end

  def update_avatar!
    set_avatar
    save
  end

  def set_avatar
    if missing_image?
      twitter_response = get_twitter_image_url if twitter
      self.image_url = twitter_response
    end
  end

  def missing_image?
    image_url.blank? || image_url == "missing_image.png" || HTTParty.get(self.image_url).code != 200
  end

  def get_twitter_image_url
    begin
      client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      end
      return client.user(self.twitter).profile_image_uri_https(:bigger).to_s
    rescue Twitter::Error::NotFound
      return "missing_image.png"
    end
  end
end
