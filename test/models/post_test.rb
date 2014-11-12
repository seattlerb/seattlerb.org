require "minitest_helper"

class PostTest < ActiveSupport::TestCase
  def test_valid_post_has_title_body_and_member
    post = Post.new()
    post.member = Member.first
    post.body = "My Long Body"
    post.title = "My test post"
    assert post.valid?
  end

  def test_invalid_posts
    post = Post.new()
    refute post.valid?

    post = Post.new(:member => Member.first)
    refute post.valid?

    post = Post.new(:title => "My test post")
    refute post.valid?

    post = Post.new(:body => "My post body")
    refute post.valid?

    post = Post.new(:body => "My post body", :title => "Title")
    refute post.valid?

    post = Post.new(:body => "My post body", :member => Member.first)
    refute post.valid?

    post = Post.new(:title => "Title", :member => Member.first)
    refute post.valid?

    post = Post.new(:title => "Title", :body => "Body", :member => Member.first)
    post.valid?
  end
end
