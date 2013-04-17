Feature: Add a new user group

  Background:
    Given I log in bus admin console as administrator

  @TC.849 @bus2.4
  Scenario: 849 Add a new user group
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 100   |
    Then New partner should be created
    When I act as newly created partner
    And I add a new itemized user group:
      | desktop storage type | desktop device | server storage type | server device |
      | Shared               | 1               | Shared             | 1             |
    Then Bundled user group should be created
    And I search and delete newly created user group name user group

  @TC.848 @bus2.4
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

  @TC.20716
  Scenario: 20716 [Bundled] Add New Group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms | company name            |
      | 12     | Silver        | 100            | yes         | yes       | [Bundled] Add New Group |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    And I act as newly created partner
    And I add a new Bundled user group:
      | name            | storage type |
      | TC.20716-Shared | Shared       |
    Then TC.20716-Shared user group should be created
    When I add a new Bundled user group:
      | name                     | storage type    | max |
      | TC.20716-Shared-with-Max | Shared with Max | 50  |
    Then TC.20716-Shared-with-Max user group should be created
    When I add a new Bundled user group:
      | name              | storage type | assigned |
      | TC.20716-Assigned | Assigned     | 50       |
    Then TC.20716-Assigned user group should be created
    When I add a new Bundled user group:
      | name          | storage type |
      | TC.20716-None | None         |
    Then TC.20716-None user group should be created
    When I add a new Bundled user group:
      | name              | storage type | enable stash | server support |
      | TC.20716-Shared-1 | Shared       | yes          | yes            |
    Then TC.20716-Shared-1 user group should be created
    When I add a new Bundled user group:
      | name                       | storage type    | max | enable stash | server support |
      | TC.20716-Shared-with-Max-1 | Shared with Max | 50  | yes          | yes            |
    Then TC.20716-Shared-with-Max-1 user group should be created
    When I add a new Bundled user group:
      | name              | storage type | assigned | enable stash | server support |
      | TC.20716-Assigned-1 | Assigned     | 50       | yes          | yes            |
    Then TC.20716-Assigned-1 user group should be created
    When I add a new Bundled user group:
      | name               | storage type |
      | TC.20716%^^&&&%$$# | None         |
    Then TC.20716%^^&&&%$$# user group should be created
    When I navigate to User Group List section from bus admin console page
    And Bundled user groups table should be:
    | Group Name                  | Stash | Server | Storage Type    | Type Value | Storage Used | Devices Used |
    | (default user group)        | true  | true   | Shared          |            | 0 bytes      | 0            |
    | TC.20716%^^&&&%$$#          | false | false  | None            |            | 0 bytes      | 0            |
    | TC.20716-Assigned           | false | false  | Assigned        | 50 GB      | 0 bytes      | 0            |
    | TC.20716-Assigned-1         | true  | true   | Assigned        | 50 GB      | 0 bytes      | 0            |
    | TC.20716-None               | false | false  | None            |            | 0 bytes      | 0            |
    | TC.20716-Shared             | false | false  | Shared          |            | 0 bytes      | 0            |
    | TC.20716-Shared-1           | true  | true   | Shared          |            | 0 bytes      | 0            |
    | TC.20716-Shared-with-Max    | false | false  | Shared with max | 50 GB      | 0 bytes      | 0            |
    | TC.20716-Shared-with-Max-1  | true  | true   | Shared with max | 50 GB      | 0 bytes      | 0            |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20899
  Scenario: 20899 [Itemized] Add New Group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name             |
      | 12     | 10    | 100 GB      | yes       | [Itemized] Add New Group |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    And I act as newly created partner
    When I add a new Itemized user group:
      | name            | desktop storage type | desktop devices | enable stash | server storage type |
      | TC.20899-Shared | Shared               | 1               | yes          | None                |
    Then TC.20899-Shared user group should be created
    When I add a new Itemized user group:
      | name                     | desktop storage type    | desktop max | desktop devices | enable stash | server storage type |
      | TC.20899-Shared-with-Max | Shared with Max         | 5           | 1               | yes          | None                |
    Then TC.20899-Shared-with-Max user group should be created
    When I add a new Itemized user group:
      | name              | desktop storage type | desktop assigned | desktop devices | enable stash | server storage type |
      | TC.20899-Assigned | Assigned             | 5                | 1               | yes          | None                |
    Then TC.20899-Assigned user group should be created
    When I add a new Itemized user group:
      | name          | desktop storage type | server storage type |
      | TC.20899-None | None                 | None                |
    Then TC.20899-None user group should be created
    When I add a new Itemized user group:
      | name              | desktop storage type | desktop devices | server storage type | server devices |
      | TC.20899-Shared-1 | Shared               | 1               | Shared              | 2              |
    Then TC.20899-Shared-1 user group should be created
    When I add a new Itemized user group:
      | name                       | desktop storage type | desktop max | desktop devices | server storage type | server max | server devices |
      | TC.20899-Shared-with-Max-1 | Shared with Max      | 5           | 1               | Shared with Max     | 10         | 2              |
    Then TC.20899-Shared-with-Max-1 user group should be created
    When I add a new Itemized user group:
      | name                | desktop storage type | desktop assigned | desktop devices | server storage type | server assigned | server devices |
      | TC.20899-Assigned-1 | Assigned             | 5                | 1               | Assigned            | 10              | 2              |
    Then TC.20899-Assigned-1 user group should be created
    When I navigate to User Group List section from bus admin console page
    And Itemized user groups table should be:
      | Group Name                  | Stash | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | (default user group)        | true  | Shared               |                    | 0 bytes              | 0                    | 4                     | Shared              |                   | 0 bytes             | 0                   | 194                  |
      | TC.20899-Assigned           | true  | Assigned             | 5 GB               | 0 bytes              | 0                    | 1                     | None                |                   | 0 bytes             | 0                   | 0                    |
      | TC.20899-Assigned-1         | false | Assigned             | 5 GB               | 0 bytes              | 0                    | 1                     | Assigned            | 10 GB             | 0 bytes             | 0                   | 2                    |
      | TC.20899-None               | false | None                 |                    | 0 bytes              | 0                    | 0                     | None                |                   | 0 bytes             | 0                   | 0                    |
      | TC.20899-Shared             | true  | Shared               |                    | 0 bytes              | 0                    | 1                     | None                |                   | 0 bytes             | 0                   | 0                    |
      | TC.20899-Shared-1           | false | Shared               |                    | 0 bytes              | 0                    | 1                     | Shared              |                   | 0 bytes             | 0                   | 2                    |
      | TC.20899-Shared-with-Max    | true  | Shared with max      | 5 GB               | 0 bytes              | 0                    | 1                     | None                |                   | 0 bytes             | 0                   | 0                    |
      | TC.20899-Shared-with-Max-1  | false | Shared with max      | 5 GB               | 0 bytes              | 0                    | 1                     | Shared with max     | 10 GB             | 0 bytes             | 0                   | 2                    |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name