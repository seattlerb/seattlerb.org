require "minitest_helper"

class MembersControllerTest < ActionController::TestCase
  def setup
    @member = Member.create!(:name        => "Test Name",
                             :verified    => true,
                             :email       => "test@test.com",
                             :password    => "password1234")
  end

  def test_index
    get :index
    assert_response :success
    assert_equal("Members",           assigns(:title))
    assert_match @member.name,        @response.body
  end
end
