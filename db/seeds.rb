# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

require 'factory_girl'

FactoryGirl.find_definitions
FactoryGirl.create(:upcoming_presentation, :presented_at => 10.days.from_now)
FactoryGirl.create(:upcoming_presentation, :presented_at => 10.days.from_now)
FactoryGirl.create(:upcoming_presentation, :presented_at => 15.days.from_now)
