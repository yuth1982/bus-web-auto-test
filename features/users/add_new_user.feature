Feature: Add a new user

  Background:
    Given I log in bus admin console as administrator

#  @TC.806 @need_test_account
#  Scenario: Add a new user to MozyEnterprise partner
#    When I act as partner by:
#      | email                                    |
#      | qa1+users+features+test+account@mozy.com |
#    When I add a new user:
#      | desktop licenses | desktop quota |
#      | 1                | 10            |
#    Then New user should be created
#    When I search user by newly created user email
#    Then User search results should be:
#      | User        | Name       | User Group           |
#      | @user_email | @user_name | (default user group) |

  @TC.20875
  Scenario: 20875 [Bundled] Add New User with default user group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 100            | yes         |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.20875-1 | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20875-2 | (default user group) | Desktop      |               | 2       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20875-3 | (default user group) | Server       | 10            | 1       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20875-4 | (default user group) | Server       |               | 2       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20875-5 | (default user group) | Desktop      |               | 2       |
      | TC.20875-6 | (default user group) | Desktop      |               | 2       |
    Then 2 new user should be created
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20875-7 | (default user group) | Server       |               | 2       |
      | TC.20875-8 | (default user group) | Server       |               | 2       |
    Then 2 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | User Group            | Stash    | Storage        |
      | TC.20875-1  | (default user group)  | Enabled  | 10 GB(Limited) |
      | TC.20875-2  | (default user group)  | Disabled | Shared         |
      | TC.20875-3  | (default user group)  | Disabled | 10 GB(Limited) |
      | TC.20875-4  | (default user group)  | Disabled | Shared         |
      | TC.20875-5  | (default user group)  | Disabled | Shared         |
      | TC.20875-6  | (default user group)  | Disabled | Shared         |
      | TC.20875-7  | (default user group)  | Disabled | Shared         |
      | TC.20875-8  | (default user group)  | Disabled | Shared         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20910
  Scenario: 20910 [Bundled] Add New User with new user group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 100            | yes         | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    And I act as newly created partner
    When I add a new Bundled user group:
      | name          | storage_type | server_support | enable_stash |
      | TC.20910 UG 1 | Shared       | yes            | yes          |
    Then TC.20910 UG 1 user group should be created
    When I add a new Bundled user group:
      | name          | storage_type | limited_quota | server_support | enable_stash |
      | TC.20910 UG 2 | Limited      | 50            | yes            | yes          |
    Then TC.20910 UG 2 user group should be created
    When I add a new Bundled user group:
      | name          | storage_type | assigned_quota | server_support | enable_stash |
      | TC.20910 UG 3 | Assigned     | 50             | yes            | yes          |
    Then TC.20910 UG 3 user group should be created
    And I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices | enable_stash |
      | TC.20910-1 | TC.20910 UG 1 | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20910-2 | TC.20910 UG 1 | Desktop      |               | 2       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20910-3 | TC.20910 UG 2 | Server       | 10            | 1       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20910-4 | TC.20910 UG 2 | Server       |               | 2       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20910-5 | TC.20910 UG 3 | Desktop      |               | 2       |
      | TC.20910-6 | TC.20910 UG 3 | Desktop      |               | 2       |
    Then 2 new user should be created
    When I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20910-7 | TC.20910 UG 3 | Server       |               | 2       |
      | TC.20910-8 | TC.20910 UG 3 | Server       |               | 2       |
    Then 2 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | User Group     | Stash    | Storage        |
      | TC.20910-1  | TC.20910 UG 1  | Enabled  | 10 GB(Limited) |
      | TC.20910-2  | TC.20910 UG 1  | Disabled | Shared         |
      | TC.20910-3  | TC.20910 UG 2  | Disabled | 10 GB(Limited) |
      | TC.20910-4  | TC.20910 UG 2  | Disabled | Shared         |
      | TC.20910-5  | TC.20910 UG 3  | Disabled | Shared         |
      | TC.20910-6  | TC.20910 UG 3  | Disabled | Shared         |
      | TC.20910-7  | TC.20910 UG 3  | Disabled | Shared         |
      | TC.20910-8  | TC.20910 UG 3  | Disabled | Shared         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20871
  Scenario: 20871 [Itemized] Add New User with default user group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | company name            |
      | 12     | 10    | 100 GB      | [Itemized] Tooltips Test|
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.20871-1 | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20871-2 | (default user group) | Desktop      |               | 1       |
    Then 1 new user should be created
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20871-3 | (default user group) | Server       | 10            | 1       |
    Then 1 new user should be created
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20871-4 | (default user group) | Server       |               | 1       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20871-5 | (default user group) | Desktop      |               | 2       |
      | TC.20871-6 | (default user group) | Desktop      |               | 2       |
    Then 2 new user should be created
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20871-7 | (default user group) | Server       |               | 2       |
      | TC.20871-8 | (default user group) | Server       |               | 2       |
    Then 2 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | User Group            | Stash    | Storage                 |
      | TC.20871-1  | (default user group)  | Enabled  | Desktop: 10 GB(Limited) |
      | TC.20871-2  | (default user group)  | Disabled | Desktop: Shared         |
      | TC.20871-3  | (default user group)  | Disabled | Server: 10 GB(Limited)  |
      | TC.20871-4  | (default user group)  | Disabled | Server: Shared          |
      | TC.20871-5  | (default user group)  | Disabled | Desktop: Shared         |
      | TC.20871-6  | (default user group)  | Disabled | Desktop: Shared         |
      | TC.20871-7  | (default user group)  | Disabled | Server: Shared          |
      | TC.20871-8  | (default user group)  | Disabled | Server: Shared          |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20906
  Scenario: 20906 [Itemized] Add New User with new user group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    And I act as newly created partner
    When I add a new Itemized user group:
      | name          | desktop_storage_type | desktop_devices | enable_stash | server_storage_type | server_devices |
      | TC.20906 UG 1 | Shared               | 2               | yes          | Shared              | 2              |
    Then TC.20906 UG 1 user group should be created
    When I add a new Itemized user group:
      | name          | desktop_storage_type | desktop_limited_quota | desktop_devices | enable_stash | server_storage_type | server_limited_quota | server_devices |
      | TC.20906 UG 2 | Limited              | 50                    | 2               | yes          | Limited             | 50                   | 2              |
    Then TC.20906 UG 2 user group should be created
    When I add a new Itemized user group:
      | name          | desktop_storage_type | desktop_assigned_quota | desktop_devices | enable_stash | server_storage_type | server_assigned_quota | server_devices |
      | TC.20906 UG 3 | Assigned             | 50                     | 4               | yes          | Assigned            | 50                    | 4              |
    Then TC.20906 UG 3 user group should be created
    And I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices | enable_stash |
      | TC.20906-1 | TC.20906 UG 1 | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    And I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20906-2 | TC.20906 UG 1 | Desktop      |               | 1       |
    Then 1 new user should be created
    And I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20906-3 | TC.20906 UG 2 | Server       | 10            | 1       |
    Then 1 new user should be created
    And I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20906-4 | TC.20906 UG 2 | Server       |               | 1       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20906-5 | TC.20906 UG 3 | Desktop      |               | 2       |
      | TC.20906-6 | TC.20906 UG 3 | Desktop      |               | 2       |
    Then 2 new user should be created
    When I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20906-7 | TC.20906 UG 3 | Server       |               | 2       |
      | TC.20906-8 | TC.20906 UG 3 | Server       |               | 2       |
    Then 2 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | User Group     | Stash    | Storage                 |
      | TC.20906-1  | TC.20906 UG 1  | Enabled  | Desktop: 10 GB(Limited) |
      | TC.20906-2  | TC.20906 UG 1  | Disabled | Desktop: Shared         |
      | TC.20906-3  | TC.20906 UG 2  | Disabled | Server: 10 GB(Limited)  |
      | TC.20906-4  | TC.20906 UG 2  | Disabled | Server: Shared          |
      | TC.20906-5  | TC.20906 UG 3  | Disabled | Desktop: Shared         |
      | TC.20906-6  | TC.20906 UG 3  | Disabled | Desktop: Shared         |
      | TC.20906-7  | TC.20906 UG 3  | Disabled | Server: Shared          |
      | TC.20906-8  | TC.20906 UG 3  | Disabled | Server: Shared          |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20921
  Scenario: 20921 [MozyPro] Add New User
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    And New partner should be created
    When I enable stash for the partner with default stash storage
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices | enable_stash |
      | TC.20921-1 | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20921-2 | Desktop      |               | 2       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20921-3 | Server       | 10            | 1       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20921-4 | Server       |               | 2       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20921-5 | Desktop      |               | 2       |
      | TC.20921-6 | Desktop      |               | 2       |
    Then 2 new user should be created
    When I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20921-7 | Server       |               | 2       |
      | TC.20921-8 | Server       |               | 2       |
    Then 2 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | Stash    | Storage        |
      | TC.20921-1  | Enabled  | 10 GB(Limited) |
      | TC.20921-2  | Disabled | Shared         |
      | TC.20921-3  | Disabled | 10 GB(Limited) |
      | TC.20921-4  | Disabled | Shared         |
      | TC.20921-5  | Disabled | Shared         |
      | TC.20921-6  | Disabled | Shared         |
      | TC.20921-7  | Disabled | Shared         |
      | TC.20921-8  | Disabled | Shared         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

