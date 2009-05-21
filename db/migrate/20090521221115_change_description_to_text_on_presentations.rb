class ChangeDescriptionToTextOnPresentations < ActiveRecord::Migration
  def self.up
    change_column :presentations, :description, :text
  end

  def self.down
    change_column :presentations, :description, :string
  end
end
