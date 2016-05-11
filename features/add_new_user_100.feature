Feature: Add a new user, execute cucumber features/add_new_user_100.feature

  Background:
    Given I log in bus admin console as administrator

  @shijing @add_new_user
  Scenario: ad new user for shijing 8 tb password is Test1234 QAP@SSw0rd
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20875-2 | (default user group) | Desktop      | 500           | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20875-3 | (default user group) | Desktop      | 500           | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20875-1 | (default user group) | Desktop      | 500           | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password


