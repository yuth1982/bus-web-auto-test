Feature: Add a new user

  Background:
    Given I log in bus admin console as administrator

  @TC.806 @need_test_account
  Scenario: Add a new user to MozyEnterprise partner
    When I act as partner by:
      | email                                    |
      | qa1+users+features+test+account@mozy.com |
    When I add a new user:
      | desktop licenses | desktop quota |
      | 1                | 10            |
    Then New user should be created
    When I search user by newly created user email
    Then User search results should be:
      | User        | Name       | User Group           |
      | @user_email | @user_name | (default user group) |
