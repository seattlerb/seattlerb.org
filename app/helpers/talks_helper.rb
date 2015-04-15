module TalksHelper
  def indefinite_Articlerize word
    word =~ /^[ai]/ ? "An #{word}" : "A #{word}"
  end

  def talk_kinds
    [["Talk Type", ""]] + Talk::TALK_KINDS.map { |k| [k.capitalize, k] }
  end

  def scheduled_date(talk)
    if talk.scheduled?
      "Scheduled for #{long_ordinal_date(talk.date)}."
    else
      "This talk has not been scheduled."
    end
  end

  def long_ordinal_date(date)
    date.to_formatted_s(:long_ordinal)
  end
end
