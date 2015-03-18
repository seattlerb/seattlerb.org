class Event < ActiveRecord::Base
  validates :date, :presence => true
  has_many :talks

  def self.next
    Event.where(date: Date.current ... Date.current + 1.month).first || Event.create!(date: first_tues_next_month)
  end

  def self.first_tues_next_month
    first_tues_month(Date.current + 1.month)
  end

  def self.first_tues_month(date)
    d = Date.new(date.year, date.month, 1)
    d += 1 until d.tuesday?
    d
  end
end
