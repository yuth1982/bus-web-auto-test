Feature: User group stash setting management

  As a Mozy customer admin
  I want to turn-on Stash for a new user group
  so that I can add Stash to the users within that group

  Background:
    Given I log in bus admin console as administrator

  @TC.19001 @BSA.2000
  Scenario: 19001 Add default stash storage for a new user group when stash is enabled for partner
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
    When I view TC.19001 group user group details
    Then User group details should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19002 @BSA.2000
  Scenario: 19002 Help displays in add new user group for default stash storage when stash is enabled for partner
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
  Scenario: 19003 No Default Storage for Stash text on add new user group section when stash is disabled for partner
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
  Scenario: 19004 Add custom stash storage for a new user group when stash is enabled for partner
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 12     | 10    | yes       |
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
  Scenario: 19005 No Enable Stash settings in user group edit page when stash is disabled for partner
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
  Scenario: 19006 Existing user groups are enabled with default stash storage when stash is enabled for partner
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
      | Yes           | 5 GB (change)          |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19007 @BSA.2010
  Scenario: 19007 Modify default stash storage quota for a user group in user group edit page when stash is enabled for partner
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
  Scenario: 19008 Disable stash for a user group in user group detail section
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
      | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota            | Desktop Keys | Desktop Quota              |
      | (default user group) * | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0  | 0 / 10       | 0.0 (10.0 active) / 250.0  |
    When I view (default user group) * user group details
    And I disable stash for the user group
    Then User group details should be:
      | Enable Stash: |
      | No            |
    When I refresh List User Group section
    And User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota            | Desktop Keys | Desktop Quota             |
      | (default user group) * | 1     | 1      | 0           | 0 / 0       | 0.0 (0.0 active) / 0.0  | 0 / 10       | 0.0 (0.0 active) / 250.0  |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19009 @BSA.2020
  Scenario: 19009 Cancel disable stash for a user group in user group detail section
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
      | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota            | Desktop Keys | Desktop Quota              |
      | (default user group) * | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0  | 0 / 10       | 0.0 (15.0 active) / 250.0  |
    When I view (default user group) * user group details
    And I cancel disable stash for the user group
    Then User group details should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 15 GB (change)         |
    When I refresh List User Group section
    And User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota            | Desktop Keys | Desktop Quota              |
      | (default user group) * | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0  | 0 / 10       | 0.0 (15.0 active) / 250.0  |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19010 @BSA.2020
  Scenario: 19010 User has not stash when disable stash for a user group in user group detail section
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
      | name           |
      | TC.19010 user  |
    Then New user should be created
    When I search user by:
    | keywords      |
    | TC.19010 user |
    And I view user details by newly created user email
    Then I should not see Enable Stash: setting on user details section
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19011 @BSA.2030
  Scenario: 19011 Add stash to all users for 0 user in the user group when stash is enabled for partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with 15 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 15 GB (change)         |
    When I act as newly created partner account
    And I navigate to List User Groups section from bus admin console page
    And I view (default user group) * user group details
    When I enable stash for all users
    Then Popup window message should be Stash has already been enabled for all users in this user group. No changes have been made.
    And I click Close button on popup window
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19012 @BSA.2030
  Scenario: 19012 A user is enabled with stash I can enable stash for other 2 users in the user group at once
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
      | name             | enable stash |
      | TC.19012.1 user  | yes          |
    Then New user should be created
    When I refresh Add New User section
    And I add a new user:
      | name             |
      | TC.19012.2 user  |
    Then New user should be created
    When I refresh Add New User section
    And I add a new user:
      | name             |
      | TC.19012.3 user  |
    Then New user should be created
    When I navigate to List User Groups section from bus admin console page
    And I view (default user group) * user group details
    And I enable stash for all users
    Then Popup window message should be Do you want to create a Stash for all 2 users with 20 GB total Desktop storage assigned for Stash usage?
    When I click Continue button on popup window
    And I refresh User Group Details section
    Then User group users list details should be:
    | Name            | Stash   | Machines | Storage | Storage Used | Created | Backed Up |
    | TC.19012.3 user | Enabled | 0        | 10 GB   | none         | today   | never     |
    | TC.19012.2 user | Enabled | 0        | 10 GB   | none         | today   | never     |
    | TC.19012.1 user | Enabled | 0        | 10 GB   | none         | today   | never     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19013 @BSA.2030
  Scenario: 19013 Enable stash to all users but not enough storage then I can choose buy more storage
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with 10000 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 10000 GB (change)      |
    When I act as newly created partner account
    And I add a new user:
      | name           |
      | TC.19013 user  |
    When I navigate to List User Groups section from bus admin console page
    And I view (default user group) * user group details
    And I enable stash for all users
    Then Popup window message should be There is not enough storage available to add the default storage amount.
    And I click Buy More button on popup window
    Then Change Plan section should be visible
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19014 @BSA.2030
  Scenario: 19014 Enable stash to all users but not enough storage then I can choose allocate more storage
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Gold          | 100            |
    Then New partner should be created
    When I enable stash for the partner with 10000 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 10000 GB (change)      |
    When I act as newly created partner account
    And I add a new user:
      | name           |
      | TC.19014 user  |
    When I navigate to List User Groups section from bus admin console page
    And I view (default user group) * user group details
    And I enable stash for all users
    Then Popup window message should be You do not have enough storage available for the default storage entered. Use the Manage Resources panel to increase the amount of storage allocated or to purchase more storage.
    And I click Allocate button on popup window
    Then Manage Resources section should be visible
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19118 @BSA.2030
  Scenario: 19118 User with a stash enabled group A should be moved to default non stash user group when I delete the user group A
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    When I navigate to List User Groups section from bus admin console page
    And I view (default user group) * user group details
    And I disable stash for the user group
    And I add a new user group:
      | name           |
      | TC.19118 group |
    Then New user group should be created
    When I transfer resources from (default user group) to TC.19118 group with:
      | desktop licenses | desktop quota GB |
      | 2                | 20               |
    Then Resources should be transferred
    When I add a new user:
      | name           | user group     | enable stash |
      | TC.19118 user  | TC.19118 group | yes          |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | Name          | User Group      | Stash   | Machines | Storage | Storage Used |
      | TC.19118 user | TC.19118 group  | Enabled | 0        | 2 GB    | none         |
    When I search and delete TC.19118 group user group
    And I refresh Search List User section
    Then User search results should be:
      | Name          | User Group           | Stash   | Machines | Storage | Storage Used |
      | TC.19118 user | (default user group) | Enabled | 0        | 2 GB    | none         |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19020 @BSA.2020
  Scenario: 19020 Delete a user group and users with storage resources are returned to default user group
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with 10 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 10 GB (change)         |
    When I act as newly created partner account
    And I add a new user group:
      | name           |
      | TC.19020 group |
    Then New user group should be created
    When I transfer resources from (default user group) to TC.19020 group with:
      | desktop licenses | desktop quota GB |
      | 2                | 20               |
    Then Resources should be transferred
    When I add a new user:
      | name           | user group     | enable stash |
      | TC.19020 user  | TC.19020 group | yes          |
    Then New user should be created
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota            | Desktop Keys | Desktop Quota            |
      | (default user group) * | 0     | 1      | 0           | 0 / 0       | 0.0 (0.0 active) / 0.0  | 0 / 8        | 0.0 (0.0 active) / 230.0 |
      | TC.19020 group         | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0  | 0 / 2        | 0.0 (10.0 active) / 20.0 |
    When I search and delete TC.19020 group user group
    And I refresh Search List User section
    Then User groups list table should be:
      | External ID | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota            | Desktop Keys | Desktop Quota              |
      |             | (default user group) * | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0  | 0 / 10       | 0.0 (10.0 active) / 250.0  |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18997 @BSA.3030
  Scenario: 18997 [List User Groups View][P]"Stash Users" column shows and has valid values
    When I act as partner by:
      | email                        |
      | test3010_3030_3040@auto.com  |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users |
      | (default user group) * | 2     | 1      | 1           |
      | backup                 | 1     | 1      | 0           |
      | stash                  | 1     | 1      | 1           |

  @TC.18998 @BSA.3030
  Scenario: 18998 [List User Groups View][P]"Desktop Quota" column includes backup and stash
    When I act as partner by:
      | email                        |
      | test3010_3030_3040@auto.com  |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota             | Desktop Keys   | Desktop Quota               |
      | (default user group) * | 2     | 1      | 1           | 0 / 0       | 0.0 (0.0 assigned) / 0.0 | 1 / 9          | 0.03 (3.0 assigned) / 230.0 |
      | backup                 | 1     | 1      | 0           | 0 / 0       | 0.0 (0.0 assigned) / 0.0 | 1 / 10         | 0.01 (1.0 assigned) / 10.0  |
      | stash                  | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 assigned) / 0.0 | 0 / 0          | 0.02 (2.0 assigned) / 10.0  |

  @TC.18999 @BSA.3030
  Scenario: 18999 [Group Detail View][P]"Stash" column shows and has valid value
    When I act as partner by:
      | email                        |
      | test3010_3030_3040@auto.com  |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota             | Desktop Keys   | Desktop Quota               |
      | (default user group) * | 2     | 1      | 1           | 0 / 0       | 0.0 (0.0 assigned) / 0.0 | 1 / 9          | 0.03 (3.0 assigned) / 230.0 |
      | backup                 | 1     | 1      | 0           | 0 / 0       | 0.0 (0.0 assigned) / 0.0 | 1 / 10         | 0.01 (1.0 assigned) / 10.0  |
      | stash                  | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 assigned) / 0.0 | 0 / 0          | 0.02 (2.0 assigned) / 10.0  |
    When I view (default user group) * user group details
    Then User group users list details should be:
      | User                 | Name        | Stash    |
      | stash19045@test.com  | stash19045  | Enabled  |
      | backup19045@test.com | backup19045 | Disabled |
    And I close the user group detail page
    When I view stash user group details
    Then User group users list details should be:
      | User            | Name  | Stash    |
      | stash@test.com  | stash | Enabled  |
    And I close the user group detail page
    When I view backup user group details
    Then User group users list details should be:
      | User            | Name   | Stash    |
      | backup@test.com | backup | Disabled |

  @TC.19000 @BSA.3030
  Scenario: 19000 [Group Detail View][P]"Storage" and "Storage Used" column includes backup and stash
    When I act as partner by:
      | email                        |
      | test3010_3030_3040@auto.com  |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota             | Desktop Keys   | Desktop Quota               |
      | (default user group) * | 2     | 1      | 1           | 0 / 0       | 0.0 (0.0 assigned) / 0.0 | 1 / 9          | 0.03 (3.0 assigned) / 230.0 |
      | backup                 | 1     | 1      | 0           | 0 / 0       | 0.0 (0.0 assigned) / 0.0 | 1 / 10         | 0.01 (1.0 assigned) / 10.0  |
      | stash                  | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 assigned) / 0.0 | 0 / 0          | 0.02 (2.0 assigned) / 10.0  |
    When I view (default user group) * user group details
    Then User group users list details should be:
      | User                 | Name        | Stash    | Machines | Storage | Storage Used |
      | stash19045@test.com  | stash19045  | Enabled  | 0        | 2 GB    | 20 MB        |
      | backup19045@test.com | backup19045 | Disabled | 1        | 1 GB    | 10 MB        |
    And I close the user group detail page
    When I view stash user group details
    Then User group users list details should be:
      | User            | Name  | Stash    | Machines | Storage | Storage Used |
      | stash@test.com  | stash | Enabled  | 0        | 2 GB    | 20 MB        |
    And I close the user group detail page
    When I view backup user group details
    Then User group users list details should be:
      | User            | Name   | Stash    | Machines | Storage | Storage Used |
      | backup@test.com | backup | Disabled | 1        | 1 GB    | 10 MB        |