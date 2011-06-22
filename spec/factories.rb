Factory.sequence(:counter) { |n| n }

Factory.define :presentation do |factory|
  factory.title          { "Test Presentation #{Factory.next(:counter)}" }
  factory.presented_at   { "May 10, 2011"                                }
  factory.video_id       { Factory.next(:counter)                        }
  factory.video_provider { 'vimeo'                                       }
  factory.description    { "Test Description #{Factory.next(:counter)}"  }
  factory.slides_url     { "http://slides.com/#{Factory.next(:counter)}" }
  factory.presenter      { Factory(:presenter)                           }
end

Factory.define :upcoming_presentation, :class => 'Presentation' do |factory|
  factory.title          { "New Upcoming Presentation"                         }
  factory.presented_at   { Date.today + 20.days                                }
  factory.presenter_name { "New Upcoming Person"                               }
  factory.description    { "New Upcoming Description"                          }
  factory.presenter      { Factory(:presenter, :name => 'New Upcoming Person') }
end

Factory.define :presenter do |factory|
  factory.name           { "Test Presenter #{Factory.next(:counter)}" }
  factory.url            { 'http://twitter.com/some_presenter'        }
end

