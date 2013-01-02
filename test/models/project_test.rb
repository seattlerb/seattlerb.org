require "minitest_helper"

class ProjectTest < MiniTest::Rails::ActiveSupport::TestCase
  def test_valid
    p = Project.new(:name => "Test Project")
    assert p.valid?
  end

  def test_invalid
    p = Project.new
    refute p.valid?
  end

  def test_dudes_association
    p = Project.create!(:name => "My Test Project")
    d = Dude.create!(:name => "John", :ruby_gems_id => "rgid")

    d.projects << p

    p.reload
    d.reload

    assert p.dudes.include? d
  end
end
