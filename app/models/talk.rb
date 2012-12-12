class Talk < ActiveRecord::Base
  TALK_KINDS = ["beginner",
                "intermediate",
                "advanced",
                "lightning"]

  validates :kind, :inclusion => { :in => TALK_KINDS,
    :message => "%{value} is not a valid talk kind" }
  validates :title, :presenter, :presence => true

end
