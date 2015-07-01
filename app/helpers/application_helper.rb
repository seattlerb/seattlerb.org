module ApplicationHelper
  def icon_link icon, text, uri, uri_prefix=nil
    return if uri.blank?

    "<li><i class='#{icon}'></i>#{link_to text, "#{uri_prefix}#{uri}"}</li>"
  end

  def rubygems_link person
    icon_link("icon-heart", "Ruby Gems", person.ruby_gems_id, "http://rubygems.org/profiles/")
  end

  def github_link person
    icon_link "icon-glass", "Github", person.github, "https://github.com/"
  end

  def website_link person
    icon_link "icon-user", "Website", person.website
  end

  def email_link person
    icon_link "icon-envelope", "Email", person.email, "mailto:"
  end

  def twitter_link person
    v = person.twitter
    icon_link "icon-leaf", "@#{v}", v, "http://twitter.com/"
  end

  def nav_item_link link_label, link_path, method=nil
    content_tag :li, link_to(link_label, link_path, method), :class => ('active' if current_page?(link_path))
  end

  def title_or_action
    @title ||= params[:action].humanize
  end
end
