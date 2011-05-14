Factory.define :presentation do |p|
  p.title          { "Test Presentation"   }
  p.presented_at   { "May 10, 2011"        }
  p.video_id       { "123"                 }
  p.video_provider { "vimeo"               }
  p.presenter_name { "Person 1"            }
  p.description    { "Test Description"    }
  p.slides_url     { "http://slides.com/1" }
end
