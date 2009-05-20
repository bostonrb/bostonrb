Feature: Blogs
  As a member of the group
  I want to see other members' blog posts
  So that I can see all the awesome stuff other members are up to

  Scenario: A signed in user sets up their blog feed
    Given I am signed up and confirmed as "email@person.com/password"
    When I sign in as "email@person.com/password"
    And I go to the homepage
    And I click "My Account"
    And I fill in "http://technicalpickles.com/posts.atom" into "Feed URL"
    And I press "Update"
