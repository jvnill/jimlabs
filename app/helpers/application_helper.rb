module ApplicationHelper
  include TagsHelper

  def page_title
    [@page_title, 'Jimlabs | Jim Ruther Nill | Ruby on Rails blog and portfolio'].compact.join(' | ')
  end

  def tabbed_link_to(name, url, section, options = {})
    if @section == section
      link_to("{#{name}}", url, options.merge({ class: 'current' }))
    else
      link_to(name, url, options)
    end
  end

  def meta_tags
    default = {}
    default[:keywords] = ['Jim Ruther Nill', 'Jimlabs', 'Ruby on Rails']
    default[:description] = ["Jimlabs: Jim Ruther Nill's Ruby on Rails blog and portfolio"]

    meta = @meta || {}
    tags = { title: page_title }

    tags[:author]      = 'Jim Ruther Nill'
    tags[:keywords]    = (Array(meta[:keywords]) + default[:keywords]).uniq.join(', ')
    tags[:description] = (Array(meta[:description]) + default[:description]).uniq.join('. ')

    tags.map do |name, content|
      content_tag(:meta, '', name: name, content: content)
    end.join.html_safe
  end

  def form_div(obj, method, options = {}, &block)
    if block_given?
      class_name = options.delete(:class)
      class_name += ' error' unless obj.errors[method].blank?
      content_tag(:div, capture(&block), options.merge(:class => class_name))
    end
  end

  def markdown(text)
    markdown_renderer.render(text).html_safe
  end

  def markdown_renderer
    renderer = CoderayCodeBlocks.new hard_wrap: true, filter_html: true
    Redcarpet::Markdown.new renderer, autolink: true, no_intra_emphasis: true, fenced_code_blocks: true
  end

  def tag_links(obj)
    obj.tag_list.collect {|tag| link_to(tag, tag_path(tag), :class => 'tag')}.join(', ').html_safe
  end

  def close_div_tag(string)
    opening = string.scan(/<div/).size
    closing = string.scan(/<\/div/).size

    (opening - closing).times do
      string += '</div>'
    end

    string
  end
end
