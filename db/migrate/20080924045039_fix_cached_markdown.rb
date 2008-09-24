class FixCachedMarkdown < ActiveRecord::Migration
  def self.up
    change_column :jobs, :cached_description_html, :text
    change_column :events, :cached_description_html, :text
  end

  def self.down
    change_column :jobs, :cached_description_html, :string
    change_column :events, :cached_description_html, :string
  end
end
