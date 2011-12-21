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
  factory.title          { "New Upcoming Presentation" }
  factory.presented_at   { Date.today + 20.days        }
  factory.presenter_name { "New Upcoming Person"       }
  factory.description    { "New Upcoming Description"  }
end

Factory.define :presenter do |factory|
  factory.name           { "Test Presenter #{Factory.next(:counter)}" }
  factory.url            { 'http://twitter.com/some_presenter'        }
end

Factory.define :blogger do |factory|
  factory.name             { 'Brian Cardarella'       }
  factory.feed_url         { 'http://a.blog.com/feed' }
  factory.twitter_username { '@brian'                 }
end

Factory.define :post do |factory|
  factory.blogger       { Factory(:blogger)                                            }
  factory.title         { 'A post about something'                                     }
  factory.summary       { 'Lots of interesting content'                                }
  factory.url           { |factory| "#{factory.blogger_url}#{Factory.next(:counter)}" }
  factory.published_at  { Time.now                                                     }
  factory.guid          { |factory| factory.url                                        }
  factory.categories    { Category.find_or_create_many_by_name(['Ruby'])               }
end

Factory.define :category do |factory|
  factory.name          { 'Ruby' }
end