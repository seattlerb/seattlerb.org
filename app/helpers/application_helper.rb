module ApplicationHelper
  
  def twitter_image(twitter_handle)
    "https://api.twitter.com/1/users/profile_image?screen_name=#{twitter_handle}&size=bigger"
  end
  
  def twitter_link(twitter)
    return if twitter.blank?
    "<li><i class='icon-leaf'></i>" +
    link_to("@#{twitter}", "http://twitter.com/#{twitter}") +
    "</li>"
  end
end
