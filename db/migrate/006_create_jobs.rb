class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.boolean :gig
      t.string :location
      t.string :organization
      t.string :title
      t.text :description
      t.string :email
      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
