require "minitest_helper"

class ApplicationHelperTest < MiniTest::Rails::ActionView::TestCase
  def test_twitter_image
    handle = "test"
    expected = "https://api.twitter.com/1/users/profile_image?screen_name=#{handle}&size=bigger"

    assert_equal expected, twitter_image(handle)
  end

  def test_icon_link_blank_uri
    assert_nil icon_link("icon", "text", "")
  end

  def test_icon_link
    icon = "icon"
    text = "text"
    uri = "/resource"
    prefix = "http://www.example.com"

    expected = "<li><i class='#{icon}'></i>#{link_to text, "#{prefix}#{uri}"}</li>"
    assert_equal expected, icon_link(icon, text, uri, prefix)
  end

  def test_rubygems_link
    person = Dude.new(:name => "Frank", :ruby_gems_id => "rgid")

    expected = "<li><i class='icon-heart'></i><a href=\"http://rubygems.org/profiles/rgid\">Ruby Gems</a></li>"
    assert_equal expected, rubygems_link(person)
  end

  def test_website_link
    person = Dude.new(:name => "Frank", :ruby_gems_id => "rgid", :website => "http://www.example.com")

    assert_equal "<li><i class='icon-user'></i><a href=\"http://www.example.com\">Website</a></li>", website_link(person)
  end

  def test_email_link
    person = Dude.new(:name => "Frank", :ruby_gems_id => "rgid", :email => "test@example.com")

    assert_equal "<li><i class='icon-leaf'></i><a href=\"http://twitter.com/@test\">@@test</a></li>", email_link(person)
  end

  def test_email_link
    person = Dude.new(:name => "Frank", :ruby_gems_id => "rgid", :twitter => "@test")

    assert_equal "<li><i class='icon-leaf'></i><a href=\"http://twitter.com/@test\">@@test</a></li>", twitter_link(person)
  end

  def test_title_or_action_without_title
    params[:action] = 'test_action'
    assert_equal 'Test action', title_or_action
  end

  def test_title_or_action_with_title
    @title = 'Some Title'
    params[:action] = 'test_action'
    assert_equal 'Some Title', title_or_action
  end

  def test_nav_item_link
    stub(:current_page?, false) do
      assert_equal '<li><a href="/people">People</a></li>', nav_item_link('People', people_path)
    end
  end

  def test_nav_item_link_active
    stub(:current_page?, true) do
      assert_equal '<li class="active"><a href="/people">People</a></li>', nav_item_link('People', people_path)
    end
  end
end
