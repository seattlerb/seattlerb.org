require "rdoc"

module ProjectsHelper
  def from_rdoc text
    options = RDoc::Options.new
    html = RDoc::Markup::ToHtml.new options
    RDoc::Markup.new.convert(text, html).html_safe
  end
end
