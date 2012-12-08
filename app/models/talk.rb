class Talk < ActiveRecord::Base
  TALK_TYPES = [:beginner,
                :intermediate,
                :advanced,
                :lightning]

  validates :kind, :inclusion => { :in => TALK_TYPES,
    :message => "%{value} is not a valid talk type" }
  validates :title, :presenter, :presence => true

end
