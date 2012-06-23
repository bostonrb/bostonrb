require 'spec_helper'

feature 'BostonRB Presentations', %{
  As a BostonRB member
  I want to see past presentations
} do

  background do
    VCR.insert_cassette('boston_rb_calendar')
    @presentation_1 = Factory(:presentation, :presented_at => "May 10, 2011")
    @presentation_2 = Factory(:presentation, :presented_at => "May 10, 2011")
    @presentation_3 = Factory(:presentation, :presented_at => "April 12, 2011")
    visit root_path
  end

  scenario 'Viewing past presentations' do
    @upcoming_presentation = Factory(:upcoming_presentation)
    click_link 'Presentations'
    have_presentation_content(@presentation_1, :should)
    have_presentation_content(@presentation_2, :should)
    have_presentation_content(@presentation_3, :should)
    have_presentation_content(@upcoming_presentation, :should_not)
  end

  scenario 'Viewing past presentation' do
    click_link 'Presentations'
    click_link @presentation_1.title
    have_presentation_content(@presentation_1, :should)
  end

  scenario 'Subscribing to RSS' do
    click_link 'Presentations'
    click_link 'RSS'
    feed = parse_feed
    have_rss_item(feed, @presentation_1)
    have_rss_item(feed, @presentation_2)
    have_rss_item(feed, @presentation_3)
  end

  scenario 'Viewing Presentation for a given month' do
    click_link 'Presentations'
    click_link 'May 10, 2011'
    have_presentation_content(@presentation_1, :should)
    have_presentation_content(@presentation_2, :should)
    have_presentation_content(@presentation_3, :should_not)
  end

  scenario 'Viewing Presentation for a specific upcoming month' do
    @presentation_4 = Factory(:presentation, :presented_at => 2.months.from_now)
    visit "/presentations/month/#{@presentation_4.presented_at.strftime('%B-%Y')}"
    have_presentation_content(@presentation_4, :should)
    page.should_not have_content('Past presentations')
  end

  scenario 'Viewing Upcoming Presentations' do
    @presentation_4 = Factory(:presentation, :presented_at => 2.weeks.from_now)
    visit '/presentations/upcoming'
    current_path.should eq "/presentations/month/#{@presentation_4.presented_at.strftime('%B-%Y')}"
  end

  def parse_feed
    SimpleRSS.parse(page.driver.browser.last_response.body)
  end

  def have_rss_item(feed, presentation)
    rss_item = feed.items.detect { |item| item.guid.to_i == presentation.id }
    rss_item.title.should eq presentation.title
    rss_item.description.should eq presentation.description
    rss_item.pubDate.to_date.should eq presentation.presented_at
    rss_item.link.should eq presentation_url(presentation)
  end

  after(:each) do
    VCR.eject_cassette
  end
end
