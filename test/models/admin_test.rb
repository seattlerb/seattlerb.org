require "minitest_helper"

class AdminTest < ActiveSupport::TestCase
  def test_validation
    admin = Admin.new(:email    => "test@example.com",
                    :password => "testtest")

    assert admin.valid?
  end
end
