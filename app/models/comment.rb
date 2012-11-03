class Comment < ActiveRecord::Base
  attr_accessible :name, :comment, :commentable_id, :commentable_type

  belongs_to :commentable, polymorphic: true

  validates :name, :comment, :commentable_id, :commentable_type, presence: true
  validates :comment, length: { maximum: 1024 }

  scope :approved, where(status: 'approved')
end
