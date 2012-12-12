module TalksHelper
  def talk_kinds
    Hash[Talk::TALK_KINDS.map { |kind| [kind, kind] }]
  end
end
