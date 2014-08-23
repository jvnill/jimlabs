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
      .group('DATE_PART(\'YEAR\', posts.created_at)::int')
      .order('date_part_year_posts_created_at_int DESC')
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

  private

  def set_path
    self.path = title.parameterize if path.blank?
  end
end
