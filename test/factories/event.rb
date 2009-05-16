Factory.define :event do |u|
  u.date        2.days.ago
  u.title       'DHH talks about patterns'
  u.description 'Whoops!'
  u.location    '41 Winter St, Boston, MA'
end

Factory.define :recurring_event, :parent => :event do |factory|
  factory.recurring true 
end

Factory.define :special_event, :parent => :event do |factory|
  factory.recurring false
end

