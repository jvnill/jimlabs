FactoryGirl.define do
  factory :portfolio do
    title 'Portfolio'
    short_description 'Description'
    url 'http://example.com'
    image_url 'http://example.com/image.png'
    active_site true
  end

  factory :post do
    title 'Post'
    body 'Post body'
    path '/post'
    meta 'post, meta'
    published true
    truncate_length 90
  end
end
