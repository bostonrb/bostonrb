class MoreVideoFields < ActiveRecord::Migration
  def self.up
    add_column :videos, :presenter, :string
    add_column :videos, :source, :string
  end

  def self.down
    remove_column :videos, :presenter
    remove_column :videos, :source
  end
end
