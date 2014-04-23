class Event < ActiveRecord::Base
  validates :date, :presence => true
  has_many :talks

  def self.next(num = 1)
    e = Event.where(date: Date.today ... Date.today + num.month).order('date ASC').first(num)
    e = Event.create!(date: first_tues_next_month) if e.blank?
    e
  end

  def self.first_tues_next_month
    first_tues_month(Date.today + 1.month)
  end

  def self.first_tues_month(date)
    d = Date.new(date.year, date.month, 1)
    d += 1 until d.tuesday?
    d
  end
end
