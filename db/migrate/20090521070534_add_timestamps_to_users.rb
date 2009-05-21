class AddTimestampsToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |table|
      table.timestamps
    end
  end

  def self.down
    remove_column :users, :created_at
    remove_column :users, :updated_at
  end
end
