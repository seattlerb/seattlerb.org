require "minitest_helper"

class CommentsControllerTest < ActionController::TestCase
  def setup
    @group = Group.create!(:book => "SICP", :active => true,
                           :github => "http://www.github.com" )
    @params = {}
    @params[:group_id] = @group.id

    @comment = Comment.create!(:group_id => @group.id, :body => "This book is great!",
                         	     :member => "David Hasselhoff" )
  end

  def test_index
    get :index, {:group_id => @params[:group_id]}
    assert_response :success
    assert_equal("Comments",       assigns(:title))
    assert_match @comment.body,          @response.body
  end

  def test_new
    get :new, {:group_id => @params[:group_id]}
    assert_response :success

    assert_select "textarea#comment_body"
    assert_select "input#comment_member"
    assert_select "input#comment_group_id"
  end

  def test_create
    @testcomment = Comment.create!(:group_id => @params[:group_id], :body => "Test comment", :member => "Ellen" )

    assert_difference('Comment.count', 1) do
      post :create, comment: {
                             :group_id => @params[:group_id],
                             :body => "Test comment2",
                             :member => "Paul"
                            }
    end

    assert_redirected_to groups_path
    get :index, {:group_id => @params[:group_id]}
    assert_response :success
    assert_match @testcomment.body, @response.body
  end

  def test_create_fails_with_spam_trap
    comment_attributes = {
                         :group_id => @params[:group_id],
                         :body => "Make money now!",
                         :member => "uxclk23",
                         :username => "SPAM"
                        }

    assert_difference('Comment.count', 0) do
      post :create, :comment => comment_attributes
    end

    assert_redirected_to groups_path
  end
end
