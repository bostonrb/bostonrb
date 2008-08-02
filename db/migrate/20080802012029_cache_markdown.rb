class CacheMarkdown < ActiveRecord::Migration
  def self.up
    [:events, :jobs, :projects].each do |table|
      add_column table, :cached_description_html, :string
    end
  end

  def self.down
    [:events, :jobs, :projects].each do |table|
      remove_column table, :cached_description_html
    end
  end
end
