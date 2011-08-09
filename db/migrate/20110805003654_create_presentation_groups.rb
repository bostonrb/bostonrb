class CreatePresentationGroups < ActiveRecord::Migration
  def change
    create_table :presentation_groups do |t|
      t.integer :presentation_id
      t.integer :presenter_id

      t.timestamps
    end
    add_index :presentation_groups, [:presentation_id,:presenter_id], :unique => true
  end
end
