require "minitest_helper"

class TalksControllerTest < MiniTest::Rails::ActionController::TestCase
  def setup
    @talk = Talk.create!(:title       => "My Test Talk",
                         :description => "Description",
                         :kind        => "beginner",
                         :email       => "a@example.com",
                         :presenter   => "Me")
  end

  def teardown
    @talk.destroy
  end

  def test_index
    get :index
    assert_response :success

    assert_select 'td', :text => @talk.title
    assert_select 'td', :text => @talk.presenter
    assert_select 'td', :text => @talk.description

    assert assigns[:talks].include?(@talk)
  end

  def test_new
    get :new

    assert_response :success

    assert_select 'input#talk_presenter'
    assert_select 'input#talk_title'
    assert_select 'textarea#talk_description'
    assert_select 'select#talk_kind'
  end

  def test_create
    talk_attributes = {
                       :title       => "Title",
                       :presenter   => "The Dude",
                       :kind        => "beginner",
                       :email       => "a@example.com",
                       :description => "My description"
                      }

    assert_difference 'Talk.count', 1 do
      post :create, :talk => talk_attributes, :password => ""
    end

    talk = Talk.find_by_title("Title")
    assert_equal "Title", talk.title
    assert_equal "My description", talk.description
    assert_equal "beginner", talk.kind
    assert_equal "The Dude", talk.presenter

    assert_redirected_to talk_path(assigns(:talk))
  end

  def test_create_fails_without_spam_blocker
    talk_attributes = {
                       :title       => "Title",
                       :presenter   => "The Dude",
                       :kind        => "beginner",
                       :email       => "a@example.com",
                       :description => "My description",
                      }


    assert_difference 'Talk.count', 0 do
      post :create, :talk => talk_attributes, :password => "spammer"
    end

    assert_redirected_to root_path
  end

  def test_show
    get :show, id: @talk

    assert_match @talk.title, @response.body
    assert_match @talk.presenter, @response.body
    assert_match @talk.description, @response.body
    assert_match @talk.kind, @response.body

    assert_response :success
  end

  def test_edit
    get :edit, id: @talk
    assert_response :success

    assert_select 'input#talk_presenter'
    assert_select 'input#talk_title'
    assert_select 'textarea#talk_description'
    assert_select 'select#talk_kind'
  end

  def test_update
    talk_attributes = { :title       => "Title",
                        :presenter   => "The Dude",
                        :kind        => "advanced",
                        :description => "My description"}

    put :update, id: @talk, talk: talk_attributes, password: ""

    assert_redirected_to talk_path(assigns(:talk))

    @talk.reload

    assert_equal "Title", @talk.title
    assert_equal "The Dude", @talk.presenter
    assert_equal "advanced", @talk.kind
    assert_equal "My description", @talk.description
  end

  def test_update
    talk_attributes = { :title       => "Title",
                        :presenter   => "The Dude",
                        :kind        => "advanced",
                        :description => "My description"}

    put :update, id: @talk, talk: talk_attributes
    assert_redirected_to root_path

    @talk.reload

    assert_equal "My Test Talk", @talk.title
    assert_equal "Me", @talk.presenter
    assert_equal "beginner", @talk.kind
    assert_equal "Description", @talk.description
  end

  def test_destroy
    assert_difference('Talk.count', -1) do
      delete :destroy, id: @talk
    end

    assert_redirected_to talks_path
  end
end
