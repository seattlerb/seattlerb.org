require "minitest_helper"

class ProjectTest < ActiveSupport::TestCase
  def test_valid
    p = Project.new(:name => "Test Project")
    assert p.valid?
  end

  def test_invalid
    p = Project.new
    refute p.valid?
  end

  def test_members_association
    p = Project.create!(:name => "My Test Project")
    d = Member.create!(:name => "John",
                       :email => "test@test.com",
                       :password => "password1234")

    d.projects << p

    p.reload
    d.reload

    assert p.members.include? d
  end
end
