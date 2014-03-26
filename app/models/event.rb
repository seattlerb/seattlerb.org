class Event < ActiveRecord::Base
  validates :date, :presence => true
  has_many :talks

  def self.next(num=1)
    Event.where(date: Date.today ... Date.today + num.month).limit(num).first || Event.create!(date: Event.first_tues_next_month)
  end

  def self.first_tues_next_month
    mo = Date.today.month+1
    yr = Date.today.year
    day = 1
    until Date.new(yr,mo,day).wday == 2 do
      day += 1
    end
    Date.new(yr,mo,day)
  end
end
