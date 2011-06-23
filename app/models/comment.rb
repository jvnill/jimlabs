class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true

  validates_presence_of :name, :comment
  validates_presence_of :commentable_id, :commentable_type

  validates_length_of :comment, :maximum => 1024

  named_scope :approved, :conditions => {:status  => 'approved'}
end
