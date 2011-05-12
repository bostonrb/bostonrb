class CreatePresentations < ActiveRecord::Migration
  def self.up
    create_table :presentations do |t|
      t.date   :presented_at
      t.string :vimeo_id
      t.string :title
      t.string :slides_url
      t.string :project_url
      t.string :project_type
      t.string :presenter_name
      t.text   :description
      t.timestamps
    end
  end

  def self.down
    drop_table :presentations
  end
end
