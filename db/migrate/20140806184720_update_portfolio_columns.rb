class UpdatePortfolioColumns < ActiveRecord::Migration
  def up
    remove_column :portfolios, :meta
    remove_column :portfolios, :path
    remove_column :portfolios, :published
    remove_column :portfolios, :photo_file_name
    remove_column :portfolios, :photo_content_type
    remove_column :portfolios, :photo_file_size
    remove_column :portfolios, :width
    remove_column :portfolios, :height
    remove_column :portfolios, :photo_updated_at
    remove_column :portfolios, :cached_tag_list
    remove_column :portfolios, :truncate_length

    add_column :portfolios, :image_url, :string
    add_column :portfolios, :short_description, :string
    add_column :portfolios, :active_site, :boolean, default: true
  end

  def down
    remove_column :portfolios, :short_description
    remove_column :portfolios, :image_url
    remove_column :portfolios, :active_site

    add_column :portfolios, :truncate_length, :integer
    add_column :portfolios, :cached_tag_list, :string
    add_column :portfolios, :photo_updated_at, :datetime
    add_column :portfolios, :height, :integer
    add_column :portfolios, :width, :integer
    add_column :portfolios, :photo_file_size, :string
    add_column :portfolios, :photo_content_type, :string
    add_column :portfolios, :photo_file_name, :string
    add_column :portfolios, :published, :boolean
    add_column :portfolios, :path, :string
    add_column :portfolios, :meta, :string
  end
end
