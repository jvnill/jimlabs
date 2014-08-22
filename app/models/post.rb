class Post < ActiveRecord::Base
  acts_as_taggable_on :tags

  validates_presence_of :title, :body

  before_save :set_path

  scope :published, -> { where(published: true) }

  def self.for_year(year)
    return all if year.blank?

    where('DATE_PART(\'YEAR\', created_at) = ?', year)
  end

  def self.count_by_year
    Post
      .published
      .group('DATE_PART(\'YEAR\', posts.created_at)')
      .order('date_part_year_posts_created_at DESC')
      .count(:id)
  end

  def self.meta_tags
    published.map(&:tag_list)
  end

  def self.meta_desc
    published.map(&:title)
  end

  def to_param
    path
  end

  def set_path
    self.path = title.downcase.gsub(/[^A-Za-z0-9]+/, '-') if path.blank?
  end
end
