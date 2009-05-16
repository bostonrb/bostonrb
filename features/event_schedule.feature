Feature: Event Schedule
  As a member of the group
  I want to see the upcoming events schedule
  So that I can attend if I am available

    Scenario: Recurring events on the homepage
      Given a future recurring event exists with a title of "Hackfest"
      And a future recurring event exists with a title of "Meeting"
      And a future recurring event exists with a title of "Pub Night"
      And a future recurring event exists with a title of "Theatre"
      When I go to the homepage
      Then I should see "Events"
      And I should see "Hackfest"
      And I should see "Meeting"
      And I should see "Pub Night"
      And I should see "Theatre"

   Scenario: Special events on the homepage
     Given an event exists with a title of "Web Inno"
     And the "Web Inno" event is not a main event
     When I go to the homepage
     Then I should see "Recurring Events"
     And I should see "Web Inno"

   Scenario: Viewing details about an event
     Given a future recurring event exists with a title of "Hackfest"
     And the "Hackfest" event's location is "41 Winter Street, Boston, MA, 02108"
     When I go to the homepage
     And I follow "Hackfest"
     Then I should see "Hackfest"
     And I should see "41 Winter Street, Boston, MA, 02108"
     And I should see a map
      
