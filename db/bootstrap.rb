require 'factory_girl'
# FIXME copy&pasted from fg... this should happen automatically
Factory.definition_file_paths = [
  File.join(RAILS_ROOT, 'test', 'factories'),
  File.join(RAILS_ROOT, 'spec', 'factories')
]
Factory.find_definitions

Bootstrapper.for :development do |b|
  Factory(:recurring_event, :title => 'Hackfest', :date => 1.week.from_now)
  Factory(:recurring_event, :title => 'Meeting', :date => 2.week.from_now)
  Factory(:recurring_event, :title => 'Hackfest', :date => 3.week.from_now)
  Factory(:recurring_event, :title => 'Theater Night', :date => 4.week.from_now)

  Factory(:special_event, :title => 'WebInno', :date => 1.week.from_now)

  Factory(:user, :email => 'josh@technicalpickles.com', :twitter => 'techpickles')
  30.times do
    Factory(:user)
  end
  Factory(:user, :email => 'dcroak@thoughtbot.com', :twitter => 'croaky')

end

Bootstrapper.for :test do |b|
end

