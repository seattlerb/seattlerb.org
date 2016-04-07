class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  NONE = "missing_image.png"

  attr_accessor :username # fake attribute for spam trapping
  validates_length_of :username, :maximum => 0

  has_many :posts
  habtm :projects, :join_table => :affiliations

  validates_presence_of :name

  validates :email,        :email => true,    :allow_blank => true, uniqueness: true
  validates :twitter,      :twitter => true,  :allow_blank => true, uniqueness: true
  validates :github,       :github => true,   :allow_blank => true, uniqueness: true
  validates :ruby_gems_id, :rubygems => true, :allow_blank => true, uniqueness: true
  validates :website,      :url => true,      :allow_blank => true, uniqueness: true

  scope :featured, -> { where(featured: true) }
  scope :regular, -> { where(featured: false) }
  scope :verified, -> { where(verified: true) }

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
    image_url.blank? || image_url == NONE || HTTParty.get(image_url).code != 200
  end

  def get_twitter_image_url
    return twitter_client.user(self.twitter).profile_image_uri_https(:bigger).to_s
  rescue Twitter::Error::NotFound
    return NONE
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end
end
