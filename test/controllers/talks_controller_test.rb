require "minitest_helper"

class TalksControllerTest < MiniTest::Rails::ActionController::TestCase
  def setup
    @talk = Talk.create!(:title       => "My Test Talk",
                         :description => "Description",
                         :kind        => :beginner,
                         :presenter   => "Me")
  end

  def teardown
    @talk.destroy
  end

  def test_index
    get :index
    assert_response :success

    assert assigns[:talks].include?(@talk)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    talk_attributes = { :title     => "Title",
                        :presenter => "The Dude",
                        :kind      => :beginner}

    assert_difference 'Talk.count', 1 do
      post :create, :talk => talk_attributes
    end

    assert_redirected_to talk_path(assigns(:talk))
  end

  def test_show
    get :show, id: @talk
    assert_response :success
  end

  def test_edit
    get :edit, id: @talk
    assert_response :success
  end

  def test_update
    talk_attributes = { :title     => "Title",
                        :presenter => "The Dude",
                        :kind      => :beginner}

    put :update, id: @talk, talk: talk_attributes
    assert_redirected_to talk_path(assigns(:talk))
  end

  def test_destroy
    assert_difference('Talk.count', -1) do
      delete :destroy, id: @talk
    end

    assert_redirected_to talks_path
  end
end
