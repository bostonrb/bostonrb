Feature: Events
  As a member of the group
  I want to see the upcoming events schedule
  So that I can attend if I am available

  Scenario: A signed in user creates a recurring event
    Given I am signed up and confirmed as "email@person.com/password"
    When I sign in as "email@person.com/password"
    And I go to the homepage
    And I follow "New Event"
    And I fill in "Date" with "tomorrow at 7PM"
    And I fill in "Title" with "Hackfest"
    And I fill in "Location" with "41 Winter Street, Boston, MA, 02018"
    And I check "Recurring"
    And I fill in "Description" with "Hack away"
    And I press "Create"
    Then I should see "Events"
    And I should see "Hackfest"
    And I should see "Hack away"

  Scenario: A signed in user creates a copy of a recurring event
    Given I am signed up and confirmed as "email@person.com/password"
    And a future recurring event exists with a title of "Hackfest"
    When I sign in as "email@person.com/password"
    And I go to the homepage
    And I follow "Hackfest"
    And I follow "Copy"
    Then I should see "Copy of Hackfest"
    And I fill in "Date" with "tomorrow at 7PM"
    And I fill in "Title" with "Hackfest squared"
    And I press "Create"
    Then I should see "Events"
    And I should see "Hackfest squared"


  Scenario: Recurring events on the homepage
    Given a future special event exists with a title of "Barcamp Boston"
    Given a future recurring event exists with a title of "Hackfest"
    And a future recurring event exists with a title of "Meeting"
    And a future recurring event exists with a title of "Pub Night"
    And a future recurring event exists with a title of "Theatre"
    When I go to the homepage
    Then I should see "Events"
    And I should see "Hackfest" under events
    And I should see "Meeting" under events
    And I should see "Pub Night" under events
    And I should see "Theatre" under events
    And I should not see "Barcamp Boston" under events

 Scenario: Special events on the homepage
   Given a future special event exists with a title of "Barcamp Boston"
   When I go to the homepage
   And I should see "Barcamp Boston" under other events

 Scenario: Viewing details about an event
   Given a future recurring event exists with a title of "Hackfest"
   And the "Hackfest" event's location is "41 Winter Street, Boston, MA, 02108"
   When I go to the homepage
   And I follow "Hackfest"
   Then I should see "Hackfest"
   And I should see "41 Winter Street, Boston, MA, 02108"
   And I should see a map

  Scenario: Viewing number of events
    Given a future special event exists with a title of "Barcamp Boston"
    Given a future recurring event exists with a title of "Hackfest"
    And a future recurring event exists with a title of "Meeting"
    And a future recurring event exists with a title of "Pub Night"
    And a future recurring event exists with a title of "Theatre"
    When I go to the homepage
    Then I should see that there are 5 future events

  Scenario: Viewing events atom feed
    Given a future special event exists with a title of "Barcamp Boston"
    Given a future recurring event exists with a title of "Hackfest"
    When I go to the events atom feed
    Then I should see an entry for "Barcamp Boston"
    And I should see an entry for "Hackfest"
    And I should not see an entry for "PHPConf"

  Scenario: Viewing events rss feed
    Given a future special event exists with a title of "Barcamp Boston"
    Given a future recurring event exists with a title of "Hackfest"
    When I go to the events rss feed
    Then I should be redirected to "the events atom feed"
