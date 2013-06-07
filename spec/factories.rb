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

  factory :event do
    project_night_url 'http://www.project.com'
    meeting_url 'http://www.meeting.com'
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
end
