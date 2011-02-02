Feature: Visitor finds next event

  As a visitor
  I want to find the next event
  In order to show up to a Boston.rb event
  
  Scenario: Visitor finds the next event
    Given I am on the home page
    Then I should see "next"
    And I should not see "No event scheduled."
    But I should see event information