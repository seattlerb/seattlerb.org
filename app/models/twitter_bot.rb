class TwitterBot
  def announce message
    twitter_client.update message
  end

  def announce_talk talk
    announce "#{when_in_words(talk.scheduled_date)} at @seattlerb, #{talk.presenter} will give the talk \"#{talk.title}\""
  end

  def announce_event event
    event.talks.map do |talk|
      announce_talk talk
    end
  end

  def when_in_words date
    distance_in_minutes = ((date.to_time - Time.now) / 60.0).round

    case distance_in_minutes
    when -Float::INFINITY...1440
      "Today"
    when 1440...2520
      "Tomorrow"
    when 2520...10080
      "This week"
    when 10080...20160
      "Next week"
    when 20160...43200
      "This month"
    when 43200...86400
      "Next month"
    when 86400...Float::INFINITY
      "In the future"
    end
  end

  def twitter_client
    TwitterClientBuilder.build
  end
end
