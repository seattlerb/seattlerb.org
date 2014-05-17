require "minitest_helper"

class MembersControllerTest < MiniTest::Rails::ActionController::TestCase
  def test_index
    get :index
    assert_response :success
    assert_equal("Members", assigns(:title))
  end

  def test_new
    get :new
    assert_response :success

    assert_select "input#member_name"
    assert_select "input#member_email"
    assert_select "input#member_ruby_gems_id"
  end

  def test_create
    assert_difference('Member.count', 1) do
      post :create, member: {:name => "test", :email => "test@test.com", :ruby_gems_id => "qrush"}
    end
    assert_redirected_to members_path
  end
end