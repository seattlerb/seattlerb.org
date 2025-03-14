class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  NONE = "missing_image.png"

  rails_admin do
    configure :set_password

    edit do
      exclude_fields :password, :password_confirmation
      include_fields :set_password
    end
  end

  def password_required? = false
  def email_required?    = false

  attr_accessor :username # fake attribute for spam trapping
  validates_length_of :username, :maximum => 0

  has_many :posts
  habtm :projects, :join_table => :affiliations

  validates_presence_of :name

  validates :email,        email:    true, allow_blank: true, uniqueness: true, allow_nil: true
  validates :twitter,      twitter:  true, allow_blank: true, uniqueness: true
  validates :github,       github:   true, allow_blank: true, uniqueness: true
  validates :ruby_gems_id, rubygems: true, allow_blank: true, uniqueness: true
  validates :website,      url:      true, allow_blank: true, uniqueness: true

  scope :verified, -> { where(verified: true) }

  def set_password; nil; end

  def set_password=(value)
    return nil if value.blank?
    self.password = value
    self.password_confirmation = value
  end

  def bio
    bio = self['bio']
    bio.present? ? bio : "..."
  end

  def missing_image?
    image_url.blank? || image_url == NONE || (image_url !~ /twimg.com/ && Net::HTTP.get_response(URI(image_url)).code != "200")
  rescue
    true
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
