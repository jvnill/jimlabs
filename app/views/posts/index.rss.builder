xml.instruct! :xml, :version => '1.0'
xml.rss :version => '2.0' do
  xml.channel do
    xml.title "Jimlabs: Jim Ruther Nill's blog"
    xml.description "Blog List under Jimlabs"
    xml.link '/blog.rss'

    @posts.each do |p|
      xml.item do
        xml.title p.title
        xml.description p.body
        xml.pubDate p.created_at.to_s(:rfc822)
        xml.link post_url(p, :format => :rss)
      end
    end
  end
end
