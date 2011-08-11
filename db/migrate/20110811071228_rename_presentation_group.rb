class RenamePresentationGroup < ActiveRecord::Migration
  def up
    rename_table :presentation_groups, :presentation_presenters
  end

  def down
    rename_table :presentation_presenters, :presentation_groups
  end
end
