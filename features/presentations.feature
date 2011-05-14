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
    And   I follow "Presentations"

  Scenario: Viewing past presentations
    Then I should see presentation 1 for May 10, 2011
    And  I should see presentation 2 for May 10, 2011
    And  I should see presentation 3 for April 12, 2011

