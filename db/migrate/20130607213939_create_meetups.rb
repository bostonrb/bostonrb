class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :project_night_url, :null => false
      t.string :meeting_url, :null => false

      t.timestamps
    end
  end
end
