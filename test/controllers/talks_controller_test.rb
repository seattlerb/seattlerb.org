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

    assert assigns[:talks].include?(@talk)

    assert_match @talk.title,       @response.body
    assert_match @talk.presenter,   @response.body
    assert_match @talk.description, @response.body
    assert_match @talk.kind,        @response.body
  end

  def test_talks_sorted_on_index
    int_one = Talk.create!(:title     => "Int 1",
                           :kind      => "intermediate",
                           :email     => "a@example.com",
                           :presenter => "Me")
    int_two = Talk.create!(:title     => "Int 2",
                           :kind      => "intermediate",
                           :email     => "a@example.com",
                           :presenter => "Me")
    beg_one = Talk.create!(:title     => "Beg 1",
                           :kind      => "beginner",
                           :email     => "a@example.com",
                           :presenter => "Me")
    beg_two = Talk.create!(:title     => "Beg 2",
                           :kind      => "beginner",
                           :email     => "a@example.com",
                           :presenter => "Me")


    get :index

    expected = [beg_one, beg_two, @talk, int_one, int_two]

    assert_equal expected, assigns[:talks]
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
      assert_redirected_to talks_path
    end

    get :index
    assert_response :success

    talk = Talk.find_by_title("Title")

    refute_nil talk
    assert_equal "Title",          talk.title
    assert_equal "My description", talk.description
    assert_equal "beginner",       talk.kind
    assert_equal "The Dude",       talk.presenter

    assert_match @talk.title,       @response.body
    assert_match @talk.presenter,   @response.body
    assert_match @talk.description, @response.body
    assert_match @talk.kind,        @response.body
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
end
