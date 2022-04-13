class Event < ApplicationRecord
  validates :date, :presence => true
  validates_uniqueness_of :date

  has_many :talks

  def self.next
    Event.where(date: Date.current ... Date.current + 1.month).first_or_create(date: first_tues_next_month)
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
