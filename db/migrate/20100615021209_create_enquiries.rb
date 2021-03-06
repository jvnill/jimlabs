class CreateEnquiries < ActiveRecord::Migration
  def self.up
    create_table :enquiries do |t|
      t.string :name
      t.string :email
      t.string :company
      t.text :message

      t.timestamps
    end
  end

  def self.down
    drop_table :enquiries
  end
end
