module ApplicationHelper
  def page_title
    [@page_title, 'Jimlabs | Jim Ruther Nill | Ruby on Rails blog and portfolio'].compact.join(' | ')
  end

  def waypoint_path(anchor)
    ''.tap do |url|
      url << '/' if controller_name != 'pages'
      url << "##{anchor}"
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

  def tag_links(obj)
    obj.tag_list.map do |tag|
      link_to(tag, tag_path(tag), class: 'tag')
    end.join(', ').html_safe
  end

  def years_experience
    days = (Date.today - Date.new(2008, 5)).to_i

    "#{days / 365} years".tap do |string|
      months = (days % 365) / 30
      string << " #{months} months" if months > 0
    end
  end

  private

  def markdown_renderer
    Redcarpet::Markdown.new(renderer,
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true
    )
  end

  def renderer
    CoderayCodeBlocks.new(hard_wrap: true, filter_html: true)
  end
end
