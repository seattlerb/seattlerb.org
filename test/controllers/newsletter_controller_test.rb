require "test_helper"

class NewsletterControllerTest < MiniTest::Rails::Controller

  def test_index
    get :index
    assert_response :success
  end

end
