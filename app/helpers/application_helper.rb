module ApplicationHelper
  def renderer
    Redcarpet::Render::HTML.new(safe_links_only: true, hard_wrap: true, prettify: true)
  end
  
  def markdown
    Redcarpet::Markdown.new(renderer, autolink: true, fenced_code_blocks: true, tables: true, 
                    strikethrough: true, underline: true, highlight: true, quote: true)
  end
end
