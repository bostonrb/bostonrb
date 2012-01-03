class SeedSettings < ActiveRecord::Migration
  def up
    [['venue_name','Microsoft NERD'],['venue_map','http://maps.google.com/maps?q=1+memorial+drive+cambridge+ma'],
      ['venue_address','1 Memorial Drive<br>Cambridge, MA 02142'],
      ['signup_link','http://guestlistapp.com/events/81732']].each do |key,value|
        Setting.create(:key => key, :value => value)
      end
  end

  def down
    ['venue_name','venue_map','venue_address','signup_link'].each do |key|
      setting = Setting.find_by_key key
      setting.destroy
    end
  end
end
