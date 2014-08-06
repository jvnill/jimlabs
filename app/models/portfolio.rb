class Portfolio < ActiveRecord::Base
  acts_as_taggable_on :tags

  validates_presence_of :url, :title, :path, :body

  scope :published, where(:published => true)

  before_validation :set_path

  def photo_url(size = :original)
    "/images/#{path.downcase}_#{size.to_s}.png"
  end

  def meta_tags
    { keywords: tag_list, description: meta}
  end

  def to_param
    path
  end

  def set_path
    self.path = title.downcase.gsub(/[^A-Za-z0-9]+/, '-') if path.blank?
  end

  def self.meta_tags
    published.collect(&:tag_list).flatten.uniq.join(',')
  end

  def self.meta_desc
    published.collect(&:title).flatten.join(',')
  end
end
