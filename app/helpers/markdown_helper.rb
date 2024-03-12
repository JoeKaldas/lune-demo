module MarkdownHelper
  def markdown(text, options = {})
    return "" if text.blank?

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    html = markdown.render(text.to_s)
    if options.delete(:strip)
      html.sub!(/^<p>/, "")
      html.sub!(/<\/p>$/, "")
    end
    html.html_safe # rubocop:disable Rails/OutputSafety
  end
  alias m markdown
end
