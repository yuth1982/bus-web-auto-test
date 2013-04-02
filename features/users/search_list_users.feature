Feature: Search and list user

  Background:
    Given I log in bus admin console as administrator

  @TC.683 @need_test_account
  Scenario: Search user
    When I act as partner by:
      | email                                    |
      | qa1+users+features+test+account@mozy.com |
    When I search user by:
      | keywords                  |
      | qa1+tc+683+user@decho.com |
    Then User search results should be:
      | User                      | Name        |
      | qa1+tc+683+user@decho.com | TC.683 User |
