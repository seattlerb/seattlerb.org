require "minitest_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    Member.create!(:name => "Big Bird")
  end

  def tear_down
    Member.destroy_all
  end

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

  def test_published_at_set_before_save
    post = Post.new(:member => Member.first,
                    :title  => "My Title",
                    :body   => "body")

    post.save!
    post.reload

    assert_nil post.published_at

    post.published = true
    post.save!

    assert_in_delta Time.now, post.published_at, 0.01
    t1 = post.published_at

    post.title = "My Title 2"
    post.save!

    assert_equal t1, post.published_at
  end
end
