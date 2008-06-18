Factory.define :place do |place|
  place.add_attribute 'name', 'Some place'
  place.address 'Some address'
  place.description { 'DESCRIPTION!' * 5 }
end
