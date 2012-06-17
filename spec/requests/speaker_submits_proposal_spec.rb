require 'spec_helper'

feature 'Speaker submits proposal', %{
  As a potential speaker
  I want to submit a proposal to BostonRB
  In order to speak to Boston Rubyists
} do

  before(:all) do
    VCR.insert_cassette('boston_rb_calendar')
  end

  background do
    visit root_path
    click_link 'Submit Proposal'
    reset_mailer
  end

  scenario 'Speaker submit proposal' do
    fill_in 'Email', :with => 'speaker@example.com'
    fill_in 'Body',  :with => 'Real-time chat apps'
    click_button 'Submit proposal'
    email = open_email('admin@bostonrb.org')
    email.default_part_body.should include 'Real-time chat apps'
  end

  scenario 'Speaker tries to submit without an email body' do
    fill_in 'Email', :with => 'speaker@example.com'
    click_button 'Submit proposal'
    mailbox_for('admin@bostonrb.org').should be_empty
  end

  scenario 'Speaker tries to submit without an email address' do
    fill_in 'Body', :with => 'Real-time chat apps'
    click_button 'Submit proposal'
    mailbox_for('admin@bostonrb.org').should be_empty
  end

  after(:all) do
    VCR.eject_cassette
  end
end
