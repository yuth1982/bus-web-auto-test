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
      | name       | storage_type | storage_max | devices | enable_stash |
      | TC.21012-1 | Desktop      | 10          | 1       | yes          |
    Then 1 new user should be created
    And I navigate to Contact section from bus admin console page
    And I add new user(s):
      | name       | storage_type | storage_max | devices |
      | TC.21012-2 | Server       |             | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    And User search results should be:
      | Name        | Stash    | Storage        |
      | TC.21012-1  | Enabled  | 10 GB(Limited) |
      | TC.21012-2  | Disabled | Shared         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name
