Feature: BostonRB Presentations

  As a BostonRB member
  I want to see past presentations

  Background:
    Given the following presentations exists:
      | title               | description        | video_id | video_provider | presented_at   | slides_url          | presenter_name |
      | Test Presentation 1 | Test Description 1 | 1        | vimeo          | May 10, 2011   | http://slides.com/1 | Person 1       |
      | Test Presentation 2 | Test Description 2 | 2        | vimeo          | May 10, 2011   | http://slides.com/2 | Person 2       |
      | Test Presentation 3 | Test Description 3 | 3        | vimeo          | April 12, 2011 | http://slides.com/3 | Person 3       |
    And   I am on the home page

  Scenario: Viewing past presentations
    Given an upcoming presentation
    When I follow "Presentations"
    Then I should see presentation 1 for May 10, 2011
    And  I should see presentation 2 for May 10, 2011
    And  I should see presentation 3 for April 12, 2011
    But  I should not see the upcoming presentation

  Scenario: Viewing past presentations
    When I follow "Presentations"
    And  I follow "Test Presentation 1"
    Then I should see presentation 1 for May 10, 2011

  Scenario: Subscribing to RSS
    When I follow "Presentations"
    And  I follow "RSS"
    And  I parse the feed
    Then I should get a rss item of presentation 1
    And  I should get a rss item of presentation 2
    And  I should get a rss item of presentation 3

