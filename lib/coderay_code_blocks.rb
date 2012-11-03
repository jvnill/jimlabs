class CoderayCodeBlocks < Redcarpet::Render::HTML
  def block_code(code, language)
    header = "<div class='header'>#{language}</div>"
    html = CodeRay.scan(code, language).html(wrap: :div)

    header + html
  end
end
