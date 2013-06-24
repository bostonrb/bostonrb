class CreateProjectNights < ActiveRecord::Migration
  def change
    create_table :project_nights do |t|
      t.string :url, :null => false

      t.timestamps
    end
  end
end
