class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :comment
      t.integer :commentable_id
      t.string :commentable_type
      t.string :name
      t.string :url
      t.string :status, :default => 'pending'

      t.timestamps
    end

    add_index :comments, :commentable_type
    add_index :comments, :commentable_id
  end

  def self.down
    drop_table :comments
  end
end
