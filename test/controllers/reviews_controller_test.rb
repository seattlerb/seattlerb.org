require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users :one
    @review = reviews(:one)
  end

  test "should get index" do
    get reviews_url
    assert_response :success
  end

  test "should get new" do
    get new_review_url
    assert_response :success
  end

  test "should create review" do
    assert_difference("Review.count") do
      post reviews_url, params: { review: { field: @review.field, message: @review.message, referrable_id: @review.referrable_id, referrable_type: @review.referrable_type, url: @review.url } }
    end

    assert_redirected_to review_url(Review.last)
  end

  test "should show review" do
    get review_url(@review)
    assert_response :success
  end

  test "should get edit" do
    get edit_review_url(@review)
    assert_response :success
  end

  test "should update review" do
    patch review_url(@review), params: { review: { field: @review.field, message: @review.message, referrable_id: @review.referrable_id, referrable_type: @review.referrable_type, url: @review.url } }
    assert_redirected_to review_url(@review)
  end

  test "should destroy review" do
    assert_difference("Review.count", -1) do
      delete review_url(@review)
    end

    assert_redirected_to reviews_url
  end
end
