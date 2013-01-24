Feature: Add a new user group

  Background:
    Given I log in bus admin console as administrator

  @TC.849 @need_test_account
  Scenario: 849 Add a new user group
    When I act as partner by:
      | email                                    |
      | qa1+users+features+test+account@mozy.com |
    When I add a new user group:
      | desktop licenses | desktop quota |
      | 1                | 10            |
    Then New user group should be created
    And I search and delete newly created user group name user group

  @TC.848 @need_test_account
  Scenario: 848 Delete a user group
    When I act as partner by:
      | email                                    |
      | qa1+users+features+test+account@mozy.com |
    When I add a new user group:
      | desktop licenses | desktop quota |
      | 1                | 10            |
    Then New user group should be created
    When I view newly created user group name user group details
    And I delete the user group
    And I navigate to List User Group section from bus admin console page
