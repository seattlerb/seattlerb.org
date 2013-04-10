require "minitest_helper"

class SuggestionsControllerTest < MiniTest::Rails::ActionController::TestCase

  before do
    @suggestion = suggestions(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:suggestions)

    body = response.body

    Suggestion.all.each do |suggestion|
      assert_includes body, suggestion.title
      assert_includes body, suggestion.suggester
    end
  end

  def test_new
    get :new
    assert_response :success

    assert_select "input#suggestion_title"
    assert_select "input#suggestion_suggester"
  end

  def test_create
    assert_difference('Suggestion.count', 1) do
      post :create, suggestion: {:title => "My title", :suggester => "Barney Rubble" }
    end
    assert_redirected_to suggestions_path
  end
end
