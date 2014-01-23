FactoryGirl.define do
  factory :presentation do
    sequence(:title)         { |n| "Test Presentation #{n}" }
    presented_at   'May 10, 2011'
    sequence(:video_id) { |n| n }
    video_provider 'vimeo'
    sequence(:description)  { |n| "Test Description #{n}" }
    sequence(:slides_url) { |n| "http://slides.com/#{n}" }
    presenter       { create(:presenter) }
  end

  factory :upcoming_presentation, :class => 'Presentation' do
    title          "New Upcoming Presentation"
    presented_at   { Date.today + 20.days }
    presenter_name 'New Upcoming Person'
    description    'New Upcoming Description'
  end

  factory :presenter do
    sequence(:name) { |n| "Test Presenter #{n}" }
    url            'http://twitter.com/some_presenter'
  end

  factory :blog do
    author           'Brian Cardarella'
    twitter_username { |blog| "@#{blog.author.gsub(' ', '_')}" }
    feed_url         'http://a.blog.com/feed'
  end


  factory :user do
    sequence(:github_uid) { |n| "#{n}"}
    sequence(:name) { |n| "Ruby#{n}"}
    display_name "peeta"
  end

  factory :location do
    name "Mission Control"
    street "33 Harrison"
    city "Boston"
    state "Massachusetts"
    zipcode "02125"
    time_of_deletion nil
  end
end
