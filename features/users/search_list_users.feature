Feature: Search and list user

  @search_user_example
  Scenario: Search user
    Given I log in bus admin console as administrator
    When I search user by:
      | keywords             |
      | backup19057@test.com |
    Then User search results should be:
      | User                 | Name         |
      | backup19057@test.com | backup19057  |