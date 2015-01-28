class Post < ActiveRecord::Base
  belongs_to :member

  validates :title,  :presence => true
  validates :body,   :presence => true
  validates :member, :presence => true

  scope :published, where(:published => true).order('published_at desc')

  before_save :update_published_at

  def update_published_at
    if self.published and self.published_changed?
      self.published_at = Time.now
    end
  end
end
