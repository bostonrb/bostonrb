class AddStreetAndZipcodeColumnsToLocation < ActiveRecord::Migration
  def up
    add_column :locations, :zipcode, :string
    add_column :locations, :suite_address, :string
  end

  def down
    remove_column :locations, :zipcode
    remove_column :locations, :suite_address
  end
end
