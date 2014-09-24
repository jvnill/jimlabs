class AddIdentifierToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :identifier, :string
  end
end
