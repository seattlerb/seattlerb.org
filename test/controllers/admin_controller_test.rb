require "minitest_helper"

class AdminControllerTest < MiniTest::Rails::Controller

  def test_index
    get :index
    assert_response :success
  end

end
