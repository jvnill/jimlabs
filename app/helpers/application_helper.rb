module ApplicationHelper
  include TagsHelper

  def page_title
    static = "Jimlabs: Jim Ruther Nill's Ruby on Rails blog and portfolio"
    @page_title ? "#{@page_title} | #{static}" : static
  end

  def tabbed_link_to(name, url, section, options = {})
    if @section == section
      content_tag :li, link_to("{#{name}}", url, options), :class => 'current'
    else
      content_tag :li, link_to(name, url, options)
    end
  end

  def meta_tags
    default = {}
    default[:keywords] = ['Jim Ruther Nill', 'Jimlabs', 'Ruby on Rails'].join(', ')
    default[:description] = ["Jimlabs: Jim Ruther Nill's Ruby on Rails blog and portfolio"].join(', ')

    meta = @meta || {}
    tags = {:title => page_title}

    tags[:author]      = 'Jim Ruther Nill'
    tags[:keywords]    = ([meta[:keywords]] << default[:keywords]).flatten.compact.join(', ')
    tags[:description] = ([meta[:description]] << default[:description]).flatten.compact.join('. ')
    tags.collect {|name, content| "<meta name=\"#{name}\" content=\"#{content}\"/>"}.join.html_safe
  end

  def form_div(obj, method, options = {}, &block)
    if block_given?
      class_name = options.delete(:class)
      class_name += ' error' if !obj.errors.on(method).blank?
      content_tag(:div, capture(&block), options.merge(:class => class_name))
    end
  end

  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    highlight(Redcarpet.new(text, *options).to_html).html_safe
  end

  def highlight(html)
    doc = Nokogiri::HTML::DocumentFragment.parse(html)
    doc.css("pre[@lang]").each do |pre|
      #pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
      header = content_tag :div, pre[:lang], :class => 'header'
      code = CodeRay.scan(pre.text.rstrip, pre[:lang])
      pre.replace header + code.html(:wrap => :div).html_safe
    end
    doc.to_s
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
