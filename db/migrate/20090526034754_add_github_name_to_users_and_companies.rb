class AddGithubNameToUsersAndCompanies < ActiveRecord::Migration
  def self.up
    add_column :users, :github, :string
    add_column :companies, :github, :string
  end

  def self.down
    remove_column :companies, :github
    remove_column :users, :github
  end
end
