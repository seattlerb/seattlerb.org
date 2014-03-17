class Dude < ActiveRecord::Base
  habtm :projects, :join_table => :affiliations

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
      twitter_response = get_twitter_info if twitter
      image_url = if twitter_response
        twitter_response["profile_image_url"].gsub(/normal/i, "bigger")
      else
        "missing_image.png"
      end
      self.image_url = image_url
    end
  end

  def missing_image?
    image_url.blank? || image_url == "missing_image.png"
  end

  def get_twitter_info
    response = HTTParty.get("https://api.twitter.com/1/users/show.json?screen_name=#{self.twitter}")
    if response.code == 200
      response.parsed_response
    else
      false
    end
  end
end
