class Post < ActiveRecord::Base
  acts_as_taggable_on :tags
  acts_as_commentable

  # VALIDATIONS
  validates_presence_of :title, :body

  # CALLBACKS
  before_save :set_path
  
  # NAMED SCOPES
  named_scope :published, :conditions => {:published => true}, :order => 'created_at desc'

  # INSTANCE METHODS
  def to_param
    path
  end

  def set_path
    self.path = title.downcase.gsub(/[^A-Za-z0-9]+/, '-') if path.blank?
  end

  # CLASS METHODS
  def self.archive_dates
    Post.published.group_by {|p| "#{Date::MONTHNAMES[p.created_at.month]} #{p.created_at.year}"}
  end

  def self.meta_tags
    published.collect(&:tag_list).flatten.uniq.join(',')
  end

  def self.meta_desc
    published.collect(&:title).flatten.join(',')
  end
end