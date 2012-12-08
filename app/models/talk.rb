class Talk < ActiveRecord::Base
  TALK_TYPES = [:beginner,
                :intermediate,
                :advanced,
                :lightning]

 validates :kind, :inclusion => { :in => %w(beginner intermediate advanced lightning), :message => "%{value} is not a valid talk type" }

end
