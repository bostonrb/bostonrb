class CreatePresenters < ActiveRecord::Migration
  def self.up
    create_table :presenters do |t|
      t.string :name
      t.string :url
      t.string :cached_slug

      t.timestamps
    end
  end

  def self.down
    drop_table :presenters
  end
end
