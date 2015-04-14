require "minitest_helper"

class CommentTest < ActiveSupport::TestCase
  def test_valid
    comment = Comment.new(:group_id => 1, :body => "This book is great!", :member => "John Carmack")
    assert comment.valid?

    comment = Comment.new(:group_id => 1, :body => "This book is great!")
    assert comment.valid?
  end

  def test_invalid
    comment = Comment.new
    refute comment.valid?

    comment = Comment.new(:group_id => 1)
    refute comment.valid?

    comment = Comment.new(:body => "This book is great!")
    refute comment.valid?

    comment = Comment.new(:group_id => 1, :body => "This book is great!", :member => "John Carmack", :username => "User")
    refute comment.valid?
  end
end
