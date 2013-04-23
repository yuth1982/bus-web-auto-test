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

  @TC.20875
  Scenario: Add a new user to Reseller partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 500            | yes         | yes       |
    Then New partner should be created
    When I act as newly created partner
    When I add 1 new user:
      | user_group           | storage_type | storage_max | devices |
      | (default user group) | Server       | 10          | 1       |
    Then 1 new user should be created

  @TC.806
  Scenario: Add a new user to MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I act as newly created partner
    When I add 2 new user:
      | user_group           | storage_type | storage_max | devices |
      | (default user group) | Desktop      | 10          | 1       |
    Then 2 new user should be created

