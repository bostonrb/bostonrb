Feature: Hackfests
  As a BostonRB member
  I want to learn more about Hackfests

  Scenario: Viewing the hackfests page
    Given I am on the home page
    When I follow "Hackfests"
    Then I should see "What is a Hackfest?"
