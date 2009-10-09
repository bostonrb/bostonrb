Factory.define :job do |u|
  u.location     'Boston, MA'
  u.organization 'thoughtbot'
  u.title        'Web Application Developer'
  u.description  'user interface to the metal - you should love doing it all.'
  u.email        { Factory.next :email }
end