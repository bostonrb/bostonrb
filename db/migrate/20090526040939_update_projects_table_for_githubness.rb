class UpdateProjectsTableForGithubness < ActiveRecord::Migration
  def self.up
    remove_column :projects, :feed_url
    remove_column :projects, :cached_description_html
    remove_column :projects, :deleted_at
    add_column :projects, :watchers, :integer, :default => 0, :null => false
    rename_column :projects, :homepage_url, :github_url
    add_column :projects, :user_id, :integer
    add_index :projects, :user_id
  end

  def self.down
    remove_index :projects, :user_id
    remove_column :projects, :user_id
    rename_column :projects, :github_url, :homepage_url
    remove_column :projects, :watchers
    add_column :projects, :deleted_at, :datetime
    add_column :projects, :cached_description_html, :string
    add_column :projects, :feed_url, :string
  end
end
