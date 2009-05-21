class DropSourceAndAddDescriptionToPresentations < ActiveRecord::Migration
  def self.up
    remove_column :presentations, :source
    add_column :presentations, :description, :string
  end

  def self.down
    remove_column :presentations, :description
    add_column :presentations, :source, :string
  end
end
