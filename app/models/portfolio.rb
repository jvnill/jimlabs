class Portfolio < ActiveRecord::Base
  validates :title, :image_url, :short_description, presence: true
  validates :url, presence: true, if: :active_site?
end
