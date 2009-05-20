Feature: Users
  As a member of the group
  I want to see other members of the group
  So that we can share the Ruby experience

    Scenario: viewing users
      Given a user exists with an email of "john@doe.com"
      When I go to the homepage
      Then I should see an avatar for "john@doe.com"

    Scenario: I sign in and edit my account
      Given I am signed up and confirmed as "email@person.com/password"
      When I sign in as "email@person.com/password"
      Then I should be signed in
      When I follow "Account"
      And I fill in "Email" with "email@person.com"
      And I fill in "Twitter" with "Croaky"
      And I press "Update"
      Then I should see "Account updated"

