module ApplicationHelper
  def nav_item_link link_label, link_path, **opts
    opts["aria-current"] = ("page" if current_page? link_path)
    content_tag :li, link_to(link_label, link_path, **opts)
  end
end
