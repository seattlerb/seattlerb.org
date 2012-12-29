class Talk < ActiveRecord::Base
  TALK_KINDS = %w(beginner intermediate advanced lightning)

  validates :kind, :inclusion => { :in => TALK_KINDS,
    :message => "%{value} is not a valid talk kind" }
  validates :title, :presenter, :presence => true

  def kind_enum
    TALK_KINDS
  end
end
