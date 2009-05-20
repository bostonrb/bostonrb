Feature: Projects
  As a member of the group
  I want to see open source projects created by the group
  So that I can contribute and find developers for hire

  Scenario: A signed in user creates a project
    Given I am signed up and confirmed as "email@person.com/password"
    When I sign in as "email@person.com/password"
    And I go to the homepage
    And I follow "New Project"
    And I fill in "Name" with "Paperclip"
    And I fill in "Homepage URL" with "http://thoughtbot.com/projects/paperclip"
    And I fill in "Description" with "Easy file attachment for ActiveRecord"
    And I press "Create"
    Then I should see "Projects"
    And I should see "Paperclip"
    And I should see "Easy file attachment for ActiveRecord"

