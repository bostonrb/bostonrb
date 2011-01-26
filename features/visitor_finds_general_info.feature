Feature: Visitor finds general info

  As a visitor
  I want to find general info about Boston.rb
  In order to decide whether to join the group

  Scenario: Visitor finds general info
    Given I am on the home page
    Then I should see "Second Tuesday of every month"
    And I should see "new Rubyists are always welcome"

