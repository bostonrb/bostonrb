Feature: Speaker submits proposal

  As a potential speaker
  I want to submit a proposal to Boston.rb
  In order to speak to Boston Rubyists

  Background:
    Given I am on the home page
    And I follow "Submit Proposal"

  Scenario: Speaker submits proposal
    When I fill in "Email" with "speaker@example.com"
    And I fill in "Body" with "Real-time chat apps"
    And I press "Submit proposal"
    Then I should see "Thanks for submitting! You'll hear from us soon."
    And "admin@bostonrb.org" should receive an email
    When "admin@bostonrb.org" opens the email
    Then they should see "Real-time chat apps" in the email body

  Scenario: Speaker tries to submit without an email body
    When I fill in "Email" with "speaker@example.com"
    And I fill in "Body" with ""
    And I press "Submit proposal"
    Then I should see "Email was not sent. Please enter some text."

  Scenario: Speaker tries to submit without an email address
    When I fill in "Email" with ""
    And I fill in "Body" with "Real-time chat apps"
    And I press "Submit proposal"
    Then I should see "Email was not sent. Please enter your email address."
