class RemovePresenterIdFromPresentations < ActiveRecord::Migration
  def up
    remove_column :presentations, :presenter_id
  end

  def down
    add_column :presentations, :presenter_id, :integer
  end
end
