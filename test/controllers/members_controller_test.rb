require "minitest_helper"

class MembersControllerTest < MiniTest::Rails::ActionController::TestCase
  def setup
    @member = Member.create!(:name        => "Test Name",
                             :verified    => true)
  end

  def test_index
    get :index
    assert_response :success
    assert_equal("Members",           assigns(:title))
    assert_match @member.name,        @response.body
  end

  def test_new
    get :new
    assert_response :success

    assert_select "input#member_name"
    assert_select "input#member_email"
    assert_select "input#member_ruby_gems_id"
  end

  def test_create
    @testmember = Member.create!(:name        => "Test Name",
                                 :verified    => true)

    assert_difference('Member.count', 1) do
      post :create, member:     {:name => "test",
                                 :email => "test@test.com",
                                 :ruby_gems_id => "qrush"}
    end
    
    assert_redirected_to members_path
    get :index
    assert_response :success
    assert_match @member.name,        @response.body
  end

  def test_create_fails_with_spam_trap
    member_attributes = {:name        => "Test Name",
                         :username    => "spam"}


    assert_difference 'Member.count', 0 do
      post :create, :member => member_attributes, :username => ""
    end

    assert_redirected_to members_path
  end
end