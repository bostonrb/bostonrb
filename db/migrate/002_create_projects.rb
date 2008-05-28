class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :homepage_url
      t.string :feed_url
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
