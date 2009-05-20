class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |table|
      table.string :name, :null => false
      table.string :website_url
      table.timestamps
    end

    add_index :companies, :name, :unique => true
  end

  def self.down
    remove_index :companies, :column => :name

    drop_table :companies
  end
end
