require "minitest_helper"

class GroupTest < ActiveSupport::TestCase
  def test_valid
    group = Group.new(:book => "SICP", :active => false)
    assert group.valid?

    group = Group.new(:book => "SICP", :active => false, :github => "http://www.github.com")
    assert group.valid?
  end

  def test_invalid
    group = Group.new
    refute group.valid?

    group = Group.new(:active => false)
    refute group.valid?

    group = Group.new(:book => "SICP", :active => false, :username => "User")
    refute group.valid?
  end
end
