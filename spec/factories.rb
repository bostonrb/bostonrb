Factory.define :presentation do |factory|
  factory.title          { "Test Presentation"   }
  factory.presented_at   { "May 10, 2011"        }
  factory.video_id       { "123"                 }
  factory.video_provider { "vimeo"               }
  factory.presenter_name { "Person 1"            }
  factory.description    { "Test Description"    }
  factory.slides_url     { "http://slides.com/1" }
end

Factory.define :upcoming_presentation, :class => 'Presentation' do |factory|
  factory.title          { "New Upcoming Presentation" }
  factory.presented_at   { Date.today + 20.days        }
  factory.presenter_name { "New Upcoming Person"       }
  factory.description    { "New Upcoming Description"  }
end
