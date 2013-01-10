class Talk < ActiveRecord::Base
  TALK_KINDS = %w(beginner intermediate advanced lightning)

  scope :by_kind, :order => "case kind when 'beginner'     then 1
                                       when 'intermediate' then 2
                                       when 'advanced'     then 3
                                       when 'lightning'    then 4
                             end, title"

  default_scope by_kind

  scope :available, by_kind.where(:completed => false)

  validates(:kind,
            :inclusion => {
                           :in => TALK_KINDS,
                           :message => "%{value} is not a valid talk kind"
                          })
  validates :title, :presenter, :email, :presence => true

  def kind_enum
    TALK_KINDS
  end
end
