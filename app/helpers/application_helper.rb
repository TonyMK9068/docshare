module ApplicationHelper
  
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(:safe_links_only => true, :hard_wrap => true)
    markdown = Redcarpet::Markdown.new(renderer, :autolink => true, :space_after_headers => true, :fenced_code_blocks => true)
    markdown.render(text).html_safe
  end
end
