Feature: Presentations
  As a visitor to BostonRB
  I want to be able to see all presentations
  As a member of BostonRB
  I want to be able to add and edit presentations
  
  # Not certain if this is good UI - Brian
  # Scenario: A visitor comes to BostonRB
  #   Given a test presentation is present
  #   When I am on the homepage
  #   Then I should see "Test Presentation"
  #   And I should see "(July 2009)"
    
  Scenario: Viewing a specific presentation page
    Given a test presentation is present
    And I am on the homepage
    When I follow "Test Presentation"
    Then I should see "Who"
    And I should see "test_speaker"
    And I should see "Where"
    And I should see "Cambridge, MA"
    And I should see "When"
    And I should see "July 14, 2009"
    And I should see "What"
    
  Scenario: Viewing a presentation that does not have a date_of
    Given a presentation without a date_of is present
    When I go to the presentation's page
    Then I should not see "When"
    
  Scenario: Adding a presentation
    Given I am signed up and confirmed as "email@person.com/password"
    When I sign in as "email@person.com/password"
    And I am on the homepage
    And I follow "New presentation"
    Then I should see "New presentation"
    And I should not see "Remember me"
    
  Scenario: Creating a presentation
    Given I am signed up and confirmed as "email@person.com/password"
    When I sign in as "email@person.com/password"
    And I go to the new presentation page
    And I fill in "Title" with "Test Presentation"
    And I fill in "Other Speakers" with "Test Speaker"
    And I fill in "Url" with "http://test.url.com"
    And I fill in "Location" with "Cambridge, MA"
    And I select "July 14, 2009" as the "Date of" date
    And I fill in "Description" with "Test Presentation Description"
    And I press "Create"
    Then I should see "Presentation created."
    
    Scenario: Viewing all presentations
      Given I am signed up and confirmed as "email@person.com/password"
      And a presentation exists with a title of "This is a presentation"
      And a presentation exists with a title of "Here is another cool presentation"
      When I sign in as "email@person.com/password"
      And I go to the homepage
      And I follow "Presentations" within "#presentations"
      Then I should see "Presentations"
      And I should see "This is a presentation"
      And I should see "Here is another cool presentation"

    Scenario: Viewing all presentations
      Given I am signed up and confirmed as "email@person.com/password"
      And a presentation exists with a title of "This is a presentation"
      And a presentation exists with a title of "Here is another cool presentation"
      When I sign in as "email@person.com/password"
      And I go to the homepage
      And I follow "Presentations" within "#presentations"
      And I follow "This is a presentation"
      Then I should see "This is a presentation"
