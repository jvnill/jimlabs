class Portfolio < ActiveRecord::Base
  validates :title, :identifier, :short_description, presence: true
  validates :identifier, uniqueness: true
  validates :url, presence: true, if: :active_site?

  def image_url(size)
    "https://dl.dropboxusercontent.com/u/32173582/jimlabs/#{size}/#{identifier}.png"
  end
end
