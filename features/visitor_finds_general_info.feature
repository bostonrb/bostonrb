Feature: Visitor finds general info

  As a visitor
  I want to find general info about Boston.rb
  In order to decide whether to join the group

  Scenario: Visitor finds general info with no upcoming presentations
    Given I am on the home page
    Then  I should see "Second Tuesday of every month"
    And   I should see "new Rubyists are always welcome"
    But   I should not see "Upcoming Presentations"

  Scenario: Visitor finds general info with upcoming presentations
    Given an upcoming presentation exists
    And   I am on the home page
    Then  I should see "Second Tuesday of every month"
    And   I should see "new Rubyists are always welcome"
    And   I should see "Upcoming Presentations"
    And   I should see "New Upcoming Presentation"
    And   I should see "New Upcoming Person"
    And   I should see "New Upcoming Description"
