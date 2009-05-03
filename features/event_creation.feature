Feature: Event Creation
  As a member of the group
  I want to create an event
  So that other members know about it

    Scenario: A signed in user
      Given I am signed up and confirmed as "email@person.com/password"
      When I sign in as "email@person.com/password"
      And I go to the events page
      And I follow "New Event"
      And I select a date 10 days in the future for "Date"
      And I fill in "Title" with "Hackfest"
      And I fill in "Location" with "41 Winter Street, Boston, MA, 02018"
      And I fill in "Description" with "Hack away"
      And I press "Create"
      Then I should see "Events"
      And I should see "Hackfest"

