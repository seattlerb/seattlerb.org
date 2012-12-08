require "minitest_helper"

class DudeTest < MiniTest::Rails::ActiveSupport::TestCase
  def test_creation
    # Only required fields are name and ruby_gems_id
    dude = Dude.create!(name: "Dude", ruby_gems_id: "Dude")
  end

  def test_bio
    with_bio = Dude.create!(name: "with_bio", ruby_gems_id: "x", bio: "Bio")
    without_bio = Dude.create!(name: "without_bio", ruby_gems_id: "x")

    assert_equal "Bio", with_bio.bio
    assert_equal "...", without_bio.bio
  end

  def test_featured_and_regular
    featured = Dude.create!(name: "featured", ruby_gems_id: "x", featured: true)
    regular = Dude.create!(name: "regular", ruby_gems_id: "x", featured: false)

    assert_equal [featured], Dude.featured
    assert_equal [regular], Dude.regular
  end

  def test_missing_image
    no_img = Dude.create!(name: "no_img", ruby_gems_id: "x")
    missing_img = Dude.create!(name: "missing_img", ruby_gems_id: "x", image_url: "missing_image.png")
    regular = Dude.create!(name: "regular", ruby_gems_id: "x", image_url: "test.png")

    assert no_img.missing_image?
    assert missing_img.missing_image?
    refute regular.missing_image?
  end
end
