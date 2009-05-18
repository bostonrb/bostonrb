Feature: Users
  As a member of the group
  I want to see other members of the group
  So that we can share the Ruby experience

  Scenario: viewing users
    Given a user exists with an email of "john@doe.com"
    When I go to the homepage
    Then I should see an avatar for "john@doe.com"
