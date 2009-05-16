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

