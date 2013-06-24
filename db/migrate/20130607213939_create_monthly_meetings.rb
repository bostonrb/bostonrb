class CreateMonthlyMeetings < ActiveRecord::Migration
  def change
    create_table :monthly_meetings do |t|
      t.string :url, :null => false

      t.timestamps
    end
  end
end
