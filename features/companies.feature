Feature: Companies
  As a member of the group
  I want to create and edit local companies
  So that we know who is working with our favorite programming language

    Scenario: I sign in and create a company
      Given I am signed up and confirmed as "email@person.com/password"
      And a user exists with a github of "Beemore"
      When I sign in as "email@person.com/password"
      Then I should be signed in
      When I follow "New company"
      And I fill in "Name" with "thoughtbot"
      And I fill in "Twitter" with "thoughtbot"
      And I fill in "Website URL" with "http://thoughtbot.com"
      And I fill in "Blog Feed URL" with "http://feeds.feedburner.com/GiantRobotsSmashingIntoOtherGiantRobots"
      And I press "Create"
      Then I should see "Company created"
      When I follow "thoughtbot"
      Then I should see "Twitter"
      When I follow "Edit"
      Then the "Name" field should contain "thoughtbot"
      And the "Twitter" field should contain "thoughtbot"
      And the "Website URL" field should contain "http://thoughtbot.com"
      And the "Blog Feed URL" field should contain "http://feeds.feedburner.com/GiantRobotsSmashingIntoOtherGiantRobots"
      When I fill in "Github Name" with "Beemore"
      And I press "Add Employee"
      Then I should see "Employees"
      And I should see "Beemore"

