require "minitest_helper"

class MemberTest < MiniTest::Rails::ActiveSupport::TestCase
  def test_valid
    member = Member.new(:name         => "Member",
                        :ruby_gems_id => "qrush",
                        :email        => "test@test.com")
    assert member.valid?
  end

  def test_bio
    with_bio    = Member.create!(:name         => "with_bio",
                                 :ruby_gems_id => "qrush",
                                 :email        => "test@test.com",
                                 :bio          => "Bio")
    without_bio = Member.create!(:name         => "without_bio",
                                 :ruby_gems_id => "qrush",
                                 :email        => "test@test.com")

    assert_equal "Bio", with_bio.bio
    assert_equal "...", without_bio.bio
  end

  def test_featured_and_regular
    featured = Member.create!(:name         => "featured",
                              :ruby_gems_id => "qrush",
                              :email        => "test@test.com",
                              :featured     => true)
    regular  = Member.create!(:name         => "regular",
                              :ruby_gems_id => "qrush",
                              :email        => "test@test.com",
                              :featured     => false)

    assert_equal [featured], Member.featured
    assert_equal [regular], Member.regular
  end

  def test_missing_image
    no_img      = Member.create!(:name         => "no_img",
                                 :ruby_gems_id => "qrush",
                                 :email        => "test@test.com")
    missing_img = Member.create!(:name         => "missing_img",
                                 :ruby_gems_id => "qrush",
                                 :email        => "test@test.com",
                                 :image_url    => "missing_image.png")
    regular     = Member.create!(:name         => "regular",
                                 :ruby_gems_id => "qrush",
                                 :email        => "test@test.com",
                                 :image_url    => "http://placekitten.com/50/50")

    assert no_img.missing_image?
    assert missing_img.missing_image?
    refute regular.missing_image?
  end
end
