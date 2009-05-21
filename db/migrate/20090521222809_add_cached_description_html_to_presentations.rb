class AddCachedDescriptionHtmlToPresentations < ActiveRecord::Migration
  def self.up
    add_column :presentations, :cached_description_html, :text
  end

  def self.down
    remove_column :presentations, :cached_description_html
  end
end
