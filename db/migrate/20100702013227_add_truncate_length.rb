class AddTruncateLength < ActiveRecord::Migration
  def self.up
    add_column :posts, :truncate_length, :integer, :default => 80
    add_column :portfolios, :truncate_length, :integer, :default => 80
  end

  def self.down
    remove_column :portfolios, :truncate_length
    remove_column :posts, :truncate_length
  end
end
