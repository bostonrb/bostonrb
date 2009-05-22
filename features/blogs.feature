Feature: Blogs
  As a member of the group
  I want to see other members' blog posts
  So that I can see all the awesome stuff other members are up to

  Scenario: A signed in user sets up their blog feed
    Given I am signed up and confirmed as "email@person.com/password"
    And I have setup my blog as "http://technicalpickles.com/posts.atom"
    And my latest post is "OMG guys, check out jeweler!"
    When I go to the homepage
    Then I should see "OMG guys, check out jeweler!"
