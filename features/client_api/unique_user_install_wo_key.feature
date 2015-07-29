Feature: unique user install w/o key client dependant on BUS


  Background:
    Given I log in bus admin console as administrator

  @TC.20262 @bus @client_api @smoke
  Scenario: 20262 Bundled - Activating machine success
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20262-1 | Desktop      | 25            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type |
      | @user_email | M_20262_user | Desktop      |
    Then activate machine result should be
      | code | body                                  |
      | 200  | {"license_key":"machine license key"} |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20369 @bus @client_api
  Scenario: 20369 Itemized - Activating machine success
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 8     | 100 GB      | yes       |
    Then New partner should be created
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | Test | Shared               | 5               | Shared              | 10             |
    And I add new user(s):
      | name          | user_group | storage_type | storage_limit | devices |
      | TC.20369.User | Test       | Desktop      | 50            | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type |
      | @user_email | M_20369_user | Desktop      |
    Then activate machine result should be
      | code | body                                  |
      | 200  | {"license_key":"machine license key"} |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name