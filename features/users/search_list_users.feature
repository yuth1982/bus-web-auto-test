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

  #
  # Pooled Storage - Search/ List User view changes
  # Redmine: 98385
  # Base case, rest to follow in subsequent commit/submission
  # All partners are created w/ storage pooling feature turned on
  #   using a call to "contact" section in-lieu of refreshing section not functioning properly
  #   in refactor-to come, will change "And I navigate to Contact section from bus admin console page"
  #   to "And I refresh Add New User section"
  #
  @TC.21012
  Scenario: 21012 Pooled Storage - User List View change - removal of assigned/used quota from Storage column
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    And New partner should be created
    When I enable stash for the partner with default stash storage
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices | enable_stash |
      | TC.21012-1 | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    And I refresh Add New User section
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.21012-2 | Server       |               | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    And User search results should be:
      | Name        | Stash    | Storage        |
      | TC.21012-1  | Enabled  | 10 GB(Limited) |
      | TC.21012-2  | Disabled | Shared         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  #
  # adding cases for pro, reseller, enterprise user list view changes
  #   all references to contact section will be changed once refresh section is running properly
  #   this is also only partners through busclient04/2.5 instance - itemized need to still be done
  #
  @TC.21014
  Scenario: 21014 Pooled Storage - Pro SMB - User List View - removal of assigned/used quota
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    And New partner should be created
    When I enable stash for the partner with default stash storage
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.21014-1 | Desktop      | 15            | 2       |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | storage_type | storage_limit | devices | enable_stash |
      | TC.21014-2 | Desktop      |               | 2       | yes          |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | storage_type | storage_limit | devices | enable_stash |
      | TC.21014-3 | Desktop      | 20            | 2       | yes          |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.21014-4 | Desktop      |               | 2       |
    Then 1 new user should be created
    And I refresh Add New User section
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.21014-5 | Server       | 25            | 2       |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.21014-6 | Server       |               | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | Stash    | Storage        |
      | TC.21014-1  | Disabled | 15 GB(Limited) |
      | TC.21014-2  | Enabled  | Shared         |
      | TC.21014-3  | Enabled  | 20 GB(Limited) |
      | TC.21014-4  | Disabled | Shared         |
      | TC.21014-5  | Disabled | 25 GB(Limited) |
      | TC.21014-6  | Disabled | Shared         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21016
  Scenario: 21016 Pool Storage - Reseller Metal - User List View change - removal of assigned/used quota
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 500            | yes         | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.21016-1 | (default user group) | Desktop      | 15            | 2       | yes          |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.21016-2 | (default user group) | Desktop      |               | 2       | yes          |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21016-3 | (default user group) | Desktop      | 35            | 2       |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21016-4 | (default user group) | Desktop      |               | 2       |
    Then 1 new user should be created
    And I refresh Add New User section
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21016-5 | (default user group) | Server       | 25            | 2       |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21016-6 | (default user group) | Server       |               | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | User Group            | Stash    | Storage        |
      | TC.21016-1  | (default user group)  | Enabled  | 15 GB(Limited) |
      | TC.21016-2  | (default user group)  | Enabled  | Shared         |
      | TC.21016-3  | (default user group)  | Disabled | 35 GB(Limited) |
      | TC.21016-4  | (default user group)  | Disabled | Shared         |
      | TC.21016-5  | (default user group)  | Disabled | 25 GB(Limited) |
      | TC.21016-6  | (default user group)  | Disabled | Shared         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21015
  Scenario: 21015 - Pool Storage - Enterprise - User List View change - removal of assigned/used quota
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.21015-1 | (default user group) | Desktop      | 10            | 2       | yes          |
    Then 1 new user should be created
    And I refresh Add New User section
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21015-2 | (default user group) | Desktop      |               | 2       |
    Then 1 new user should be created
    And I refresh Add New User section
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.21015-3 | (default user group) | Desktop      |               | 2       | yes          |
    Then 1 new user should be created
    And I refresh Add New User section
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21015-4 | (default user group) | Desktop      | 18            | 2       |
    Then 1 new user should be created
    And I refresh Add New User section
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21015-5 | (default user group) | Server       |               | 1       |
    Then 1 new user should be created
    And I refresh Add New User section
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21015-6 | (default user group) | Server       | 22            | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | User Group            | Stash    | Storage        |
      | TC.21015-1  | (default user group)  | Enabled  | 10 GB(Limited) |
      | TC.21015-2  | (default user group)  | Disabled | Shared         |
      | TC.21015-3  | (default user group)  | Enabled  | Shared         |
      | TC.21015-4  | (default user group)  | Disabled | 18 GB(Limited) |
      | TC.21015-5  | (default user group)  | Disabled | Shared         |
      | TC.21015-6  | (default user group)  | Disabled | 22 GB(Limited) |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name
