require "minitest_helper"

class BookTest < ActiveSupport::TestCase
  def test_valid
    b = Book.new :title => "SICP",
      :author => "Harold Abelson, Gerald Jay Sussman, Julie Sussman",
      :comment => ""
    assert b.valid?
  end

  def test_invalid_book
    book = Book.new
    refute book.valid?
  end
end
