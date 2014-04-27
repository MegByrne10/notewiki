module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new 
    extentions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extentions)
    (redcarpet.render text).html_safe   
  end
end
