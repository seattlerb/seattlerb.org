require "minitest_helper"

class MemberTest < ActiveSupport::TestCase
  include FakeNetwork

  def test_valid
    member = Member.new(:name => "Member",
                        :email => "test@test.org",
                        :password => "password1234")
    assert member.valid?
  end

  def test_invalid
    member = Member.new
    refute member.valid?
  end

  def test_valid_email
    member = Member.new(:name  => "Member",
                        :email => "test1@test.com",
                        :password => "password1234")
    assert member.valid?
  end

  def test_invalid_email
    member = Member.new(:name  => "Member",
                        :email => "test!test.com",
                        :password => "password1234")
    refute member.valid?
  end

  def test_valid_password
    member = Member.new(:name  => "Member",
                        :email => "test@test.com",
                        :password => "password1234")
    assert member.valid?
  end

  def test_invalid_password
    member = Member.new(:name  => "Member",
                        :email => "test!test.com",
                        :password => "123")
    refute member.valid?
  end

  def test_valid_github
    good_net_response do
      member = Member.new(:name     => "Member",
                          :github   => "phiggins",
                          :email    => "pete@gmail.com",
                          :password => "password1234")
      assert member.valid?
    end
  end

  def test_invalid_github
    skip "dunno why this is valid"

    member = Member.new(:name     => "Member",
                        :email    => "pete@gmail.com",
                        :password => "password1234",
                        :github   => "not_a_user234890")
    refute member.valid?
  end

  def test_valid_rubygems
    good_net_response do
      member = Member.new(:name         => "Member",
                          :email        => "pete@gmail.com",
                          :password     => "password1234",
                          :ruby_gems_id => "qrush")

      assert_predicate member, :valid?
    end
  end

  def test_invalid_rubygems
    bad_net_response do
      member = Member.new(:name         => "Member",
                          :email        => "pete@gmail.com",
                          :password     => "password1234",
                          :ruby_gems_id => "not_a_user234890")

      refute_predicate member, :valid?
    end
  end

  def test_valid_twitter
    good_net_response do
      member = Member.new(:name    => "Member",
                          :email => "pete@gmail.com",
                          :password => "password1234",
                          :twitter => "tlynam")
      assert member.valid?
    end
  end

  def test_invalid_twitter
    skip "dunno why this is valid"

    member = Member.new(:name    => "Member",
                        :twitter => "not_a_user234890",
                        :email => "pete@gmail.com",
                        :password => "password1234")
    refute member.valid?
  end

  def test_valid_url
    member = Member.new(:name    => "Member",
                        :website => "http://www.google.com",
                        :email => "pete@gmail.com",
                        :password => "password1234")
    assert member.valid?
  end

  def test_invalid_url
    member = Member.new(:name    => "Member",
                        :website => "ftp://www.notawebsite",
                        :email => "pete@gmail.com",
                        :password => "password1234")
    refute member.valid?
  end

  def test_crap_in_url
    member = Member.new(:name    => "Member",
                        :website => "http://www.google.com (lulz not rly)",
                        :email => "pete@gmail.com",
                        :password => "password1234")
    refute member.valid?
  end

  def test_bio
    with_bio    = Member.create!(:name         => "with_bio",
                                 :email        => "test1@test.com",
                                 :bio          => "Bio",
                                 :password     => "password1234")
    without_bio = Member.create!(:name         => "without_bio",
                                 :email        => "test@test.com",
                                 :password     => "password82")

    assert_equal "Bio", with_bio.bio
    assert_equal "...", without_bio.bio
  end

  def test_missing_image
    no_img      = Member.create!(:name      => "no_img",
                                 :email     => "test3@test.com",
                                 :password => "password1234")
    missing_img = Member.create!(:name      => "missing_img",
                                 :email     => "test@4test.com",
                                 :image_url => "missing_image.png",
                                 :password => "password1234")
    regular     = Member.create!(:name      => "regular",
                                 :email     => "test5@test.com",
                                 :image_url => "http://placekitten.com/50/50",
                                 :password => "password1234")

    bad_net_response do
      assert_predicate no_img,      :missing_image?
      assert_predicate missing_img, :missing_image?
    end

    good_net_response do
      refute_predicate regular,     :missing_image?
    end
  end
end
