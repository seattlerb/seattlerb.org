require "minitest_helper"

class AboutControllerTest < MiniTest::Rails::ActionController::TestCase
  def test_index
    get :index
    assert_response :success
    assert_equal("Home", assigns(:title))

    assert_template :partial => '_maps'
    assert_template :partial => '_twitter'
  end

  def test_people
    people = (1..3).map{ |x| Dude.create!(:name => x, :ruby_gems_id => "#{x}_id")}

    get :people
    assert_response :success
    assert_equal people.sort, assigns(:people).sort
  end

  def test_projects
    projects = (1..3).map { |x| Project.create!(:name => x)}

    get :projects
    assert_response :success
    assert_equal projects.sort, assigns(:projects).sort
  end

  def test_join_us
    get :join_us
    assert_response :success

    assert_template :partial => '_maps'
    assert_template :partial => '_twitter'
  end
end
