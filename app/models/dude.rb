class Dude < ActiveRecord::Base
  has_many :projects, through: :affiliations
  has_many :affiliations

  validates_presence_of :name
  # our migrations are so stupid. If we nuke the data, this conditional can go
  validates_presence_of :ruby_gems_id, :if => proc { |u| u.respond_to? :ruby_gems_id }

  scope :featured, where(featured: true)
  scope :regular, where(featured: false)

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
      image_url = get_twitter_info(self.twitter) if twitter
      # image_url = if twitter_response
      #   twitter_response["profile_image_url"].gsub(/normal/i, "bigger")
      # else
      #   "missing_image.png"
      # end
      self.image_url = image_url
    end
  end

  def missing_image?
    image_url.blank? || image_url == "missing_image.png"
  end

  def get_twitter_info(twitter_name)
    twitter_client.user_search(twitter_name).first.profile_image_url
    # response = HTTParty.get("https://api.twitter.com/1.1/users/show.json?screen_name=#{self.twitter}")
    # if response.code == 200
    #   response.parsed_response
    # else
    #   false
    # end
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_API_KEY"]
      config.consumer_secret = ENV["TWITTER_API_SECRET"]
      config.access_token = ENV["TWITTER_ACCESS_KEY"]
      config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
    end
  end

end
