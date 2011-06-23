class AddTagCache < ActiveRecord::Migration
  def self.up
    add_column :posts, :cached_tag_list, :string
    add_column :portfolios, :cached_tag_list, :string
  end

  def self.down
  end
end
