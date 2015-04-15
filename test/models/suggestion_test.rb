require "minitest_helper"

class SuggestionTest < ActiveSupport::TestCase
  def test_valid
    suggestion = Suggestion.new(:title => "WOOT", :suggester => "Fred", :comment => "")
    assert suggestion.valid?
  end

  def test_invalid
    suggestion = Suggestion.new
    refute suggestion.valid?
  end
end
