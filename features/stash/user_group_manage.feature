Feature: User group stash setting management

  As a Mozy customer admin
  I want to turn-on Stash for a new user group
  so that I can add Stash to the users within that group

  Background:
    Given I log in bus admin console as administrator

  @TC.19001 @BSA.2000
  Scenario: Add default stash storage for a new user group when stash is enabled for partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user group:
      | name           |
      | TC.19001 group |
    Then New user group should be created
    When I navigate to List User Groups section from bus admin console page
    When I view newly created user group name user group details
    Then User group details should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19002 @BSA.2000
  Scenario: Help displays in add new user group for default stash storage when stash is enabled for partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    And I act as newly created partner account
    And I navigate to Add New User Group section from bus admin console page
    Then I can see help icon for default stash storage
    And Defaut stash storage help message should be Each new user that has Stash enabled will start out with this amount of storage. You can change the user's Stash storage amount in the Users list.
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19003 @BSA.2000
  Scenario: No Default Storage for Stash text on add new user group section when stash is disabled for partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New User Group section from bus admin console page
    Then I should not see Default Storage for Stash text on add new user group section
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19004 @BSA.2000
  Scenario: Add custom stash storage for a new user group when stash is enabled for partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user group:
      | name           | stash quota |
      | TC.19004 group | 10          |
    Then New user group should be created
    When I navigate to List User Groups section from bus admin console page
    When I view newly created user group name user group details
    Then User group details should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 10 GB (change)         |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19005 @BSA.2010
  Scenario: No Enable Stash settings in user group edit page when stash is disabled for partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    And I act as newly created partner account
    When I navigate to List User Groups section from bus admin console page
    When I view (default user group) * user group details
    Then I should not see Enable Stash text on user group details section
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19006 @BSA.2010
  Scenario: Existing user groups are enabled with default stash storage when stash is enabled for partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Gold          | 100            |
    Then New partner should be created
    When I enable stash for the partner with 5 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 5 GB (change)          |
    When I act as newly created partner account
    When I navigate to List User Groups section from bus admin console page
    And I view (default user group) * user group details
    Then User group details should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 5 GB (change)         |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19007 @BSA.2010
  Scenario: Modify default stash storage quota for a user group in user group edit page when stash is enabled for partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Platinum      | 100            |
    Then New partner should be created
    When I enable stash for the partner with 15 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 15 GB (change)         |
    When I act as newly created partner account
    When I navigate to List User Groups section from bus admin console page
    And I view (default user group) * user group details
    And I enable stash for the user group with 20 GB stash storage
    Then User group details should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 20 GB (change)         |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19008 @BSA.2020
  Scenario: Disable stash for a user group in user group detail section
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with 10 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 10 GB (change)         |
    When I act as newly created partner account
    And I add a new user:
    | name           | enable stash |
    | TC.19008 user  | yes          |
    Then New user should be created
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
    | External ID | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota              | Desktop Keys | Desktop Quota                |
    |             | (default user group) * | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 assigned) / 0.0  | 0 / 10       | 0.0 (10.0 assigned) / 250.0  |
    When I view (default user group) * user group details
    And I disable stash for the user group
    Then User group details should be:
      | Enable Stash: |
      | No            |
    When I refresh List User Group section
    And User groups list table should be:
      | External ID | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota              | Desktop Keys | Desktop Quota               |
      |             | (default user group) * | 1     | 1      | 0           | 0 / 0       | 0.0 (0.0 assigned) / 0.0  | 0 / 10       | 0.0 (0.0 assigned) / 250.0  |

  @TC.19009 @BSA.2020
  Scenario: Cancel disable stash for a user group in user group detail section
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with 15 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 15 GB (change)         |
    When I act as newly created partner account
    And I add a new user:
      | name           | enable stash |
      | TC.19009 user  | yes          |
    Then New user should be created
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | External ID | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota              | Desktop Keys | Desktop Quota                |
      |             | (default user group) * | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 assigned) / 0.0  | 0 / 10       | 0.0 (15.0 assigned) / 250.0  |
    When I view (default user group) * user group details
    And I cancel disable stash for the user group
    Then User group details should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 15 GB (change)         |
    When I refresh List User Group section
    And User groups list table should be:
      | External ID | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota              | Desktop Keys | Desktop Quota               |
      |             | (default user group) * | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 assigned) / 0.0  | 0 / 10       | 0.0 (15.0 assigned) / 250.0  |

  @TC.19010 @BSA.2020
  Scenario: User has not stash when disable stash for a user group in user group detail section
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with 20 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 20 GB (change)         |
    When I act as newly created partner account
    When I navigate to List User Groups section from bus admin console page
    And I view (default user group) * user group details
    And I disable stash for the user group
    And I add a new user:
      | name           | email                      |
      | TC.19010 user  | qa1+tc+19019+user@mozy.com |
    Then New user should be created
    When I search user by:
    | keywords      |
    | TC.19010 user |
    And I view user details by qa1+tc+19019+user@mozy.com
    Then I should not see Enable Stash: setting on user details section

#  @TC.19020 @BSA.2020
#  Scenario: Given 1 user is enabled stash, I delete the user group and users with storage resources are allocated to default user group
#    When I log in bus admin console as administrator
#    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
#    And I enale stash for the partner
#      | stash |
#      | 15    |
#    And I act as newly created partner account
#    And I add a new user group:
#    And I delete newly created user group
#    Then the newly created user should be moved to default user group and storage should be moved to default group
#
#  # Enable stash for all users
#  @BSA.#2030 @TC.19011
#  Scenario: Given stash is enabled for partner, I can enable stash for 0 user in the user group
#    When I log in bus admin console as administrator
#    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
#    And I enable stash for the partner
#      | stash |
#      | 15    |
#    And I act as newly created partner account
#    And I navigate to user group list page
#    And I enable stash for all users
#    Then I should see confirmation message:
#     | users | storage |
#     | 0     | 0       |
#
#  @BSA.#2030 @TC.19012
#  Scenario: Given stash is enabled for partner and 1 user is enabled with stash, I can enable stash for other 2 users in the user group at once
#    When I log in bus admin console as administrator
#    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
#    And I enable stash for the partner
#      | stash |
#      | 15    |
#    And I act as newly created partner account
#    And I add a new user under default group
#    And I add a new user under default group
#    And I add a new user under default group with stash enabled
#    And I navigate to user group list page
#    And I enable stash for all users
#    Then I should see confirmation message:
#      | users | storage |
#      | 2     | 30      |
#    And I click yes
#    Then I should see user list with 3 users enabled with stash
#
#  @BSA.#2030 @TC.19013
#  Scenario: Given stash is enabled for partner but not enough storage for all users to enable stash I can choose buy more storage
#    When I log in bus admin console as administrator
#    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
#    And I enable stash for the partner
#      | stash |
#      | 10000 |
#    And I act as newly created partner account
#    And I add a new user under default group
#    And I navigate to user group list page
#    And I enable stash for all users
#    Then I should see error message that I have no enough storage
#    And I click buy storage
#    Then I should be navigated to buy storage page
#
#  @BSA.#2030 @TC.19014
#  Scenario: Given stash is enabled for partner but not enough storage for all users to enable stash I can choose allocate more storage
#    When I log in bus admin console as administrator
#    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
#    And I enable stash for the partner
#      | stash |
#      | 10000 |
#    And I act as newly created partner account
#    And I add a new user under default group
#    And I navigate to user group list page
#    And I enable stash for all users
#    Then I should see error message that I have no enough storage
#    And I click allocate more storage
#    Then I should be navigated to allocate storage page
#
#    @BSA.#2030 @TC.19020
#    Scenario: Given 1 user is enabled stash, I delete the user group and users with storage resources are allocated to default user group
#    When I log in bus admin console as administrator
#    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
#    And I enale stash for the partner
#      | stash |
#      | 15    |
#    And I act as newly created partner account
#    And I add a new user group:
#    And I delete newly created user group
#    Then the newly created user should be moved to default user group and storage should be moved to default group
#
#    @BSA.#2030 @TC.19018
#    Scenario: Given 1 user is enabled stash, I delete the user group and users with storage resources are allocated to
#default user group who has no stash enabled
#    When I log in bus admin console as administrator
#    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
#    And I enale stash for the partner
#      | stash |
#      | 15    |
#    And I act as newly created partner account
#    And I add a new user group:
#    And I delete newly created user group
#    Then the newly created user should be moved to default user group and stash should be disabled for the user and storage is returned
