require "minitest_helper"

class MemberTest < ActiveSupport::TestCase
  def test_valid
    member = Member.new(:name => "Member")
    assert member.valid?
  end

  def test_invalid
    member = Member.new()
    refute member.valid?
  end

  def test_valid_email
    member = Member.new(:name  => "Member",
                        :email => "test1@test.com")
    assert member.valid?
  end

  def test_invalid_email
    member = Member.new(:name  => "Member",
                        :email => "test!test.com")
    refute member.valid?
  end

  def test_valid_github
    member = Member.new(:name   => "Member",
                        :github => "phiggins")
    assert member.valid?
  end

  def test_invalid_github
    member = Member.new(:name   => "Member",
                        :github => "not_a_user234890")
    refute member.valid?
  end

  def test_valid_rubygems
    member = Member.new(:name         => "Member",
                        :ruby_gems_id => "qrush")
    assert member.valid?
  end

  def test_invalid_rubygems
    member = Member.new(:name         => "Member",
                        :ruby_gems_id => "not_a_user234890")
    refute member.valid?
  end

  def test_valid_twitter
    member = Member.new(:name    => "Member",
                        :twitter => "tlynam")
    assert member.valid?
  end

  def test_invalid_twitter
    member = Member.new(:name    => "Member",
                        :twitter => "not_a_user234890")
    refute member.valid?
  end

  def test_valid_url
    member = Member.new(:name    => "Member",
                        :website => "http://www.google.com")
    assert member.valid?
  end

  def test_invalid_url
    member = Member.new(:name    => "Member",
                        :website => "ftp://www.notawebsite")
    refute member.valid?
  end

  def test_bio
    with_bio    = Member.create!(:name         => "with_bio",
                                 :ruby_gems_id => "aaronp",
                                 :email        => "test1@test.com",
                                 :bio          => "Bio")
    without_bio = Member.create!(:name         => "without_bio",
                                 :ruby_gems_id => "qrush",
                                 :email        => "test@test.com")

    assert_equal "Bio", with_bio.bio
    assert_equal "...", without_bio.bio
  end

  def test_featured_and_regular
    featured = Member.create!(:name     => "featured",
                              :email    => "test2@test.com",
                              :featured => true)
    regular  = Member.create!(:name     => "regular",
                              :email    => "test@test.com",
                              :featured => false)

    assert_equal [featured], Member.featured
    assert_equal [regular], Member.regular
  end

  def test_missing_image
    no_img      = Member.create!(:name      => "no_img",
                                 :email     => "test3@test.com")
    missing_img = Member.create!(:name      => "missing_img",
                                 :email     => "test@4test.com",
                                 :image_url => "missing_image.png")
    regular     = Member.create!(:name      => "regular",
                                 :email     => "test5@test.com",
                                 :image_url => "http://placekitten.com/50/50")

    assert no_img.missing_image?
    assert missing_img.missing_image?
    refute regular.missing_image?
  end
end
