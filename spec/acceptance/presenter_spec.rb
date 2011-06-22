require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'BostonRB Presenters' do

  background do
    setup_presenters
    visit root_path
  end

  scenario 'Viewing presentations by presenter' do
    click_link 'Presentations'
    within '#2011-05-10' do
      click_link @presenter_1.name
    end
    have_presentation_content(@presentation_1, :should)
    have_presentation_content(@presentation_2, :should_not)
    have_presentation_content(@presentation_3, :should)
  end
end

feature 'LeaderBoard' do

  background do
    setup_presenters
    visit root_path
  end

  scenario 'Viewing' do
    visit '/presenters/leaders'

    within '#2_presentations' do
      page.should have_content @presenter_1.name
    end

    within '#1_presentations' do
      page.should have_content @presenter_2.name
    end
  end
end

def setup_presenters
  @presenter_1 = Factory(:presenter)
  @presenter_2 = Factory(:presenter)
  @presentation_1 = Factory(:presentation, :presented_at => "May 10, 2011", :presenter => @presenter_1)
  @presentation_2 = Factory(:presentation, :presented_at => "May 10, 2011", :presenter => @presenter_2)
  @presentation_3 = Factory(:presentation, :presented_at => "April 12, 2011", :presenter => @presenter_1)
end

