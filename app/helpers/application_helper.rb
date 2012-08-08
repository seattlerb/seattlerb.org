module ApplicationHelper
  def twitter_link(twitter)
    return if twitter.blank?
    "<li><i class='icon-leaf'></i>" +
    link_to("@#{twitter}", "http://twitter.com/#{twitter}") +
    "</li>"
  end
end
