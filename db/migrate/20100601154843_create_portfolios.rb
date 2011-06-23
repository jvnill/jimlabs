class CreatePortfolios < ActiveRecord::Migration
  def self.up
    create_table :portfolios do |t|
      t.string :url
      t.string :title
      t.string :meta
      t.string :path
      t.text :body
      t.boolean :published

      t.timestamps
    end
  end

  def self.down
    drop_table :portfolios
  end
end
