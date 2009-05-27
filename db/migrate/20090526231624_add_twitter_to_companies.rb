class AddTwitterToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :twitter, :string
  end

  def self.down
    remove_column :companies, :twitter
  end
end
