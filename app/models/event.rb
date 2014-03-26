class Event < ActiveRecord::Base
  validates :date, :presence => true
  has_many :talks

  def self.next(num=1)
    Event.where(date: Date.today ... Date.today + num.month).limit(num).first
  end
end
