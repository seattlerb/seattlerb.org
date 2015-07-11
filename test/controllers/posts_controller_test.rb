require "minitest_helper"

class PostsControllerTest < ActionController::TestCase

  def setup
    Member.create!(:name => "Big Bird", :email => "t@t.com", :password => "p1234")
    Post.all.each { |p| p.update_attribute(:member, Member.first) }
    @post = posts(:one)
  end

  def tear_down
    Member.destroy_all
  end

  def test_index
    get :index
    assert_response :success
    refute_nil assigns(:posts)

    Post.all.each do |p|
      assert_match p.title, @response.body
      assert_match p.body[0..10], @response.body
      assert_match p.member.name, @response.body
    end
  end

  def test_show
    get :show, id: @post
    assert_response :success
    assert_match @post.title, @response.body
    assert_match @post.body, @response.body
    assert_match @post.member.name, @response.body
  end

end
