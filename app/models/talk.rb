class Talk < ActiveRecord::Base
  attr_accessor :spam # fake attribute for spam trapping
  attr_accessor :special_talk_requests # fake attribute for spam trapping

  belongs_to :event

  TALK_KINDS = %w(beginner intermediate advanced lightning)

  validates_length_of :spam, :maximum => 0
  validates :title, :presenter, :email, :presence => true
  validates :kind, inclusion: {
    in: TALK_KINDS,
    message: "%{value} is not a valid talk kind"
  }

  delegate :date, to: :event, allow_nil: true

  scope :by_kind, lambda {
    joins("LEFT JOIN events ON  talks.event_id = events.id")
      .select("talks.*, events.date")
      .order("talks.event_id IS NULL,
              events.date,
              CASE talks.kind WHEN 'beginner'     THEN 1
                              WHEN 'intermediate' THEN 2
                              WHEN 'advanced'     THEN 3
                              WHEN 'lightning'    THEN 4
              END,
              talks.presenter,
              talks.title")
  }

  def self.available
    by_kind.where("completed = ?
                   and (talks.event_id is NULL
                   or events.date < ?)",
                   false,
                   28.days.from_now)
  end

  def self.older
    by_kind.where("completed = ?", true)
  end

  def scheduled?
    date
  end

  def kind_enum
    TALK_KINDS
  end
end
