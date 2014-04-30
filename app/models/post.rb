class Post < ActiveRecord::Base
  acts_as_taggable_on :tags
  acts_as_commentable

  attr_accessible :title, :meta, :path, :tag_list, :truncate_length,
                  :published, :body

  # VALIDATIONS
  validates_presence_of :title, :body

  # CALLBACKS
  before_save :set_path

  # NAMED SCOPES
  scope :published, where(:published => true).order('created_at DESC')

  def self.for_date(date)
    return scoped if date.blank?

    where("DATE_PART('YEAR', created_at) = ? AND DATE_PART('MONTH', created_at) = ?", date.year, date.month)
  end

  # INSTANCE METHODS
  def to_param
    path
  end

  def set_path
    self.path = title.downcase.gsub(/[^A-Za-z0-9]+/, '-') if path.blank?
  end

  # CLASS METHODS
  def self.archive_dates
    Post.published.group_by {|p| "#{Date::ABBR_MONTHNAMES[p.created_at.month]} #{p.created_at.year}"}
  end

  def self.meta_tags
    published.collect(&:tag_list).flatten.uniq.join(',')
  end

  def self.meta_desc
    published.collect(&:title).flatten.join(',')
  end
end
