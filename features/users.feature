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
      And I fill in "Email" with "new-email@person.com"
      And I fill in "Twitter" with "Croaky"
      And I fill in "Blog Feed URL" with "http://dancroak.tumblr.com/rss"
      And I press "Update"
      Then I should see "Account updated"
      When I follow "Account"
      Then the "Email" field should contain "new-email@person.com"
      And the "Twitter" field should contain "Croaky"
      And the "Blog Feed URL" field should contain "http://dancroak.tumblr.com/rss"
