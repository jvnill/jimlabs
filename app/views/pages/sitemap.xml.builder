xml.instruct!
xml.urlset("xmlns" => "http://www.google.com/schemas/sitemap/0.84", "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance", "xsi:schemaLocation" => "http://www.google.com/schemas/sitemap/0.84 http://www.google.com/schemas/sitemap/0.84/sitemap.xsd") {
  xml.url {
    xml.loc root_url
    xml.changefreq 'daily'
    xml.priority 1
  }
  xml.url {
    xml.loc posts_url
    xml.changefreq 'daily'
    xml.priority 0.9
  }
  xml.url {
    xml.loc portfolios_url
    xml.changefreq 'daily'
    xml.priority 0.9
  }
  @posts.each do |p|
    xml.url {
      xml.loc post_url(p)
      xml.changefreq 'monthly'
      xml.priority 0.8
    }
  end
  @portfolios.each do |p|
    xml.url {
      xml.loc portfolio_url(p)
      xml.changefreq 'monthly'
      xml.priority 0.7
    }
  end
}
