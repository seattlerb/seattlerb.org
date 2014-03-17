class Talk < ActiveRecord::Base

  attr_accessor :spam # fake attribute for spam trapping
  attr_accessor :special_talk_requests # fake attribute for spam trapping
  validates_length_of :spam, :maximum => 0

  TALK_KINDS = %w(beginner intermediate advanced lightning)

  scope :by_kind, :order => "scheduled_date IS NULL,
                             scheduled_date,
                             CASE kind WHEN 'beginner'     THEN 1
                                       WHEN 'intermediate' THEN 2
                                       WHEN 'advanced'     THEN 3
                                       WHEN 'lightning'    THEN 4
                             END,
                             presenter,
                             title"

  def self.available
    by_kind.where("completed = ? and (scheduled_date is NULL or scheduled_date < ?)",
                  false,
                  28.days.from_now)
  end

  def self.proposable_dates
    1.upto(12).map do |increment| 
      future_month = Date.today + increment.months
      option = Date.new(future_month.year, future_month.month, 1)
      option += 1 until option.tuesday?
      option
    end
  end

  validates(:kind,
            :inclusion => {
                           :in => TALK_KINDS,
                           :message => "%{value} is not a valid talk kind"
                          })
  validates :title, :presenter, :email, :presence => true
  validate :validate_proposed_date

  def scheduled?
    self.scheduled_date
  end

  def kind_enum
    TALK_KINDS
  end

  private

  def validate_proposed_date
    return if proposed_date.blank?
    if self.class.proposable_dates.exclude? proposed_date
      errors.add(:proposed_date, "isn't one of the event dates")
    end
  end

end
