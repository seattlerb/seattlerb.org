require "minitest_helper"

class BooksControllerTest < ActionController::TestCase
  def setup
    @testmember = Member.create!(:name        => "Test Name",
                                 :verified    => true,
                                 :email       => "test2@test.com",
                                 :password    => "password1234")
    sign_in :member, @testmember

    @book = Book.create! :title => "SICP", :member => @testmember,
      :author => "Harold Abelson, Gerald Jay Sussman, Julie Sussman",
      :comment => ""
  end

  def test_index
    get :index
    assert_response :success
    assert_equal("Lending Library",    assigns(:title))
    assert_match @book.title,          @response.body
  end

  def test_new
    get :new
    assert_response :success

    assert_select "input#book_title"
    assert_select "input#book_author"
    assert_select "textarea#book_comment"
  end

  def test_create
    assert_difference('Book.count', 1) do
      post :create, book: {
        :title => "Winnie The Pooh",
        :author => "A. A. Milne",
        :comment => "Favorite book"
      }
    end

    assert_redirected_to books_path
    get :index
    assert_response :success
    assert_match "Winnie The Pooh", @response.body
  end
end
