module TalksHelper
  def indefinite_Articlerize word
    word =~ /^[ai]/ ? "An #{word}" : "A #{word}"
  end

  def talk_kinds
    [["Talk Type", ""]] + Talk::TALK_KINDS.map { |k| [k.capitalize, k] }
  end
end
