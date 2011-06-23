class PresentationSlugs < ActiveRecord::Migration
  def self.up
    add_column :presentations, :cached_slug, :string
  end

  def self.down
    remove_column :presentations, :cached_slug
  end
end
