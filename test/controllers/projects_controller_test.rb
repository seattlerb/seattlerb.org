require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:fake1)

    @user = users :one
    sign_in_as @user if name =~ /AUTH/
  end

  test "should get index" do
    get projects_url
    assert_response :success
  end

  test "should get new" do
    get new_project_url
    assert_redirected_to new_session_path
  end

  test "should get new AUTH" do
    get new_project_url
    assert_response :success
  end

  test "should create project AUTH" do
    assert_difference("Project.count") do
      post projects_url, params: {
        project: {
          description: @project.description,
          name: @project.name,
          url: "https://rubygems.org/gems/fake"
        }
      }
    end

    assert_redirected_to project_url(Project.last)
  end

  test "should show project" do
    get project_url(@project)
    assert_response :success
  end

  test "should get edit AUTH" do
    get edit_project_url(@project)
    assert_response :success
  end

  test "should update project AUTH" do
    patch project_url(@project), params: { project: { description: @project.description, name: @project.name } }
    assert_redirected_to project_url(@project)
  end

  test "should destroy project AUTH" do
    assert_difference("Project.count", -1) do
      delete project_url(@project)
    end

    assert_redirected_to projects_url
  end
end
