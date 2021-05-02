require "minitest_helper"

class Members::RegistrationsControllerTest < ActionController::TestCase
  def test_new
    @request.env["devise.mapping"] = Devise.mappings[:member]
    get :new
    assert_response :success

    assert_select "input#member_name"
    assert_select "input#member_email"
    assert_select "input#member_ruby_gems_id"
  end

  def test_create
    @testmember = Member.create!(:name        => "Test Name",
                                 :verified    => true,
                                 :email       => "test2@test.com",
                                 :password    => "password1234")

    assert_difference('Member.count', 1) do
      @request.env["devise.mapping"] = Devise.mappings[:member]
      post :create, params: {
        member: {:name => "test",
                 :email => "test3@test.com",
                 :ruby_gems_id => "qrush",
                 :password => "password1234"} }
    end

    assert_redirected_to members_path
  end

  def test_create_fails_with_spam_trap
    member_attributes = {:name        => "Test Name",
                         :username    => "spam",
                         :password    => "password1234"}

    assert_difference 'Member.count', 0 do
      @request.env["devise.mapping"] = Devise.mappings[:member]
      post :create, params: { :member => member_attributes }
    end

    assert_redirected_to members_path
  end
end
