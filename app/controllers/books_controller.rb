class BooksController < ApplicationController
  before_action :verify_member, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @title = "Lending Library"
  end

  def new
    redirect_to books_path, notice: 'You must be signed in to list a book.' unless current_member
    @book = Book.new
  end

  def create
    #spam catch to redirect - maybe the bots were ignoring the spam field
    redirect_to books_url and return if book_params[:username].present? || !current_member

    @book = Book.new **book_params.symbolize_keys, :member_id => current_member.id

    respond_to do |format|
      if @book.save
        format.html { redirect_to books_path, notice: 'Thank you for listing your book.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    if @book.update **book_params.symbolize_keys, :member_id => current_member.id
      redirect_to member_path(current_member), notice: 'Thank you for updating your book.'
    else
      render action: "new"
    end
  end

  def destroy
    @book.destroy
    redirect_to member_path(current_member), notice: 'Book was successfully removed.'
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :comment)
  end

  def verify_member
    @book = Book.find params[:id]
    redirect_to books_path, notice: 'You can only modify your own books.' unless @book.member == current_member
  end
end
