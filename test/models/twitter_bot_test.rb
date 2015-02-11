require "minitest_helper"

class TwitterBotTest < ActiveSupport::TestCase
  class TwitterClientMock
    def update message, options={}
      message
    end
  end

  def setup
    @twitter_bot = TwitterBot.new

    def @twitter_bot.twitter_client
      TwitterClientMock.new
    end

    @gandalf_tweet = 'Today at @seattlerb, Gandalf will give the talk "Unicorns & Rainbows"'

    @event = Event.create! date: 1.hour.from_now

    @talk = Talk.create! title: "Unicorns & Rainbows",
                         presenter: "Gandalf",
                         email: "gandalf@middleearth.com",
                         kind: 'beginner',
                         completed: false,
                         scheduled_date: 1.hour.from_now,
                         event: @event
  end

  def test_announce
    tweet = @twitter_bot.announce @gandalf_tweet
    assert_equal @gandalf_tweet, tweet
  end

  def test_announce_talk
    tweet = @twitter_bot.announce_talk @talk
    assert_equal @gandalf_tweet, tweet
  end

  def test_announce_event
    tweets = @twitter_bot.announce_event @event
    assert_equal [@gandalf_tweet], tweets
  end

  def test_when_in_words_today
    words = @twitter_bot.when_in_words Time.now
    assert_equal "Today", words
  end

  def test_when_in_words_tomorrow
    words = @twitter_bot.when_in_words 1.day.from_now
    assert_equal "Tomorrow", words
  end

  def test_when_in_words_this_week
    words = @twitter_bot.when_in_words 6.days.from_now
    assert_equal "This week", words
  end

  def test_when_in_words_next_week
    words = @twitter_bot.when_in_words 8.days.from_now
    assert_equal "Next week", words
  end

  def test_when_in_words_this_month
    words = @twitter_bot.when_in_words 15.days.from_now
    assert_equal "This month", words
  end

  def test_when_in_words_next_month
    words = @twitter_bot.when_in_words 35.days.from_now
    assert_equal "Next month", words
  end

  def test_when_in_words_in_the_future
    words = @twitter_bot.when_in_words 180.days.from_now
    assert_equal "In the future", words
  end
end
