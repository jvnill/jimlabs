class Portfolio < ActiveRecord::Base
  acts_as_taggable_on :tags
  acts_as_commentable

  # VALIDATIONS
  validates_presence_of :url, :title, :path, :body

  # NAMED SCOPE
  scope :published, where(:published => true)

  # CALLBACKS
  before_validation :set_path

  # INSTANCE METHODS
  def photo_url(size = :original)
    "/images/#{path.downcase}_#{size.to_s}.png"
  end

  def meta_tags
    {:keywords => tag_list, :description => meta}
  end

  def to_param
    path
  end

  def set_path
    self.path = title.downcase.gsub(/[^A-Za-z0-9]+/, '-') if path.blank?
  end

  # CLASS METHODS
  def self.meta_tags
    published.collect(&:tag_list).flatten.uniq.join(',')
  end

  def self.meta_desc
    published.collect(&:title).flatten.join(',')
  end
end
