Feature: Jobs
  As a member of the group
  I want to see the jobs
  So that I can apply and make some $$ Benjamins $$ 

  Scenario: Viewing all jobs
    Given I am signed up and confirmed as "email@person.com/password"
    And a job exists with a title of "This is a job"
    And a job exists with a title of "Here is another cool job"
    When I sign in as "email@person.com/password"
    And I go to the homepage
    And I follow "Jobs" within "#jobs"
    Then I should see "Jobs"
    And I should see "This is a job"
    And I should see "Here is another cool job"
    And I should see "Boston, MA"
    
  Scenario: Viewing all jobs
    Given I am signed up and confirmed as "email@person.com/password"
    And a job exists with a title of "This is a job"
    And a job exists with a title of "Here is another cool job"
    When I sign in as "email@person.com/password"
    And I go to the homepage
    And I follow "Jobs" within "#jobs"
    And I follow "This is a job"
    Then I should see "This is a job at thoughtbot"
    And I should see "user interface to the metal - you should love doing it all."

  Scenario: Viewing jobs atom feed
    Given a job exists with a title of "This is a job"
    And a job exists with a title of "Here is another cool job"
    When I go to the jobs atom feed
    Then I should see "This is a job at thoughtbot"
    And I should see an entry for "Here is another cool job at thoughtbot"
