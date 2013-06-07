

# feature 'Speaker submits proposal', %{
#   As a potential speaker
#   I want to submit a proposal to BostonRB
#   In order to speak to Boston Rubyists
# } do

#   before(:all) do
#     VCR.insert_cassette('boston_rb_calendar')
#   end

#   background do
#     visit root_path
#     click_link 'Submit Proposal'
#     clear_emails
#   end

#   scenario 'Speaker submit proposal' do
#     fill_in 'Email', :with => 'speaker@example.com'
#     fill_in 'Body',  :with => 'Real-time chat apps'
#     click_button 'Submit proposal'
#     open_email('admin@bostonrb.org')
#     current_email.should have_content 'Real-time chat apps'
#   end

#   scenario 'Speaker tries to submit without an email body' do
#     fill_in 'Email', :with => 'speaker@example.com'
#     click_button 'Submit proposal'
#     emails_sent_to('admin@bostonrb.org').should be_empty
#   end

#   scenario 'Speaker tries to submit without an email address' do
#     fill_in 'Body', :with => 'Real-time chat apps'
#     click_button 'Submit proposal'
#     emails_sent_to('admin@bostonrb.org').should be_empty
#   end

#   after(:all) do
#     VCR.eject_cassette
#   end
# end

require 'spec_helper'

feature 'Admin updates RSVP link', %{
  As a BostonRB admin
  I want to update the RSVP links
  so that users can RSVP for meetings
} do

  background do
    @event = create(:event)
    visit root_path
  end

  scenario 'Logging in' do
    login
    visit admin_events_path
    page.driver.response.status.should == 200
  end

  scenario 'View existing url' do
    login
    visit admin_events_path
    have_event_content(@event, :should)
  end


end
