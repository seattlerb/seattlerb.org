require "minitest_helper"

class GroupsControllerTest < ActionController::TestCase
  def setup
    @group = Group.create!(:book => "SICP", :active => true,
                         	 :github => "http://www.github.com" )
  end

  def test_index
    get :index
    assert_response :success
    assert_equal("Study Groups",       assigns(:title))
    assert_match @group.book,          @response.body
  end

  def test_new
    get :new
    assert_response :success

    assert_select "input#group_book"
    assert_select "select#group_active"
    assert_select "input#group_github"
  end

  def test_create
    @testgroup = Group.create!(:book => "The Elements of Computing Systems by Noam Nisan and Shimon Schocken",
    													 :active => false, :github => "www.google.com" )

    assert_difference('Group.count', 1) do
      post :create, group: {
                             :book => "Winnie The Pooh",
                             :active => false,
                             :github => "www.yahoo.com"
                            }
    end

    assert_redirected_to groups_path
    get :index
    assert_response :success
    assert_match @testgroup.book, @response.body
  end

  def test_create_fails_with_spam_trap
    group_attributes = {
                         :book => "Instant Money!!",
                         :active => true,
                         :github => "uxclk23",
                         :username => "SPAM"
                        }

    assert_difference('Group.count', 0) do
      post :create, :group => group_attributes
    end

    assert_redirected_to groups_path
  end
end
