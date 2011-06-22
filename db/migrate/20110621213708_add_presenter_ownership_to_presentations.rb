class AddPresenterOwnershipToPresentations < ActiveRecord::Migration
  def self.up
    add_column :presentations, :presenter_id, :integer
  end

  def self.down
    remove_column :presentations, :presenter_id
  end
end

