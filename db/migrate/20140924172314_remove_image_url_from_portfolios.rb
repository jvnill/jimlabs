class RemoveImageUrlFromPortfolios < ActiveRecord::Migration
  def change
    remove_column :portfolios, :image_url, :string
  end
end
