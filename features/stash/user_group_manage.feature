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
    And I add a new user to a MozyEnterprise partner:
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
    And I add a new user to a MozyEnterprise partner:
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
    And I add a new user to a MozyEnterprise partner:
      | name           | email                      |
      | TC.19010 user  | qa1+tc+19019+user@mozy.com |
    Then New user should be created
    When I search user by:
    | keywords      |
    | TC.19010 user |
    And I view user details by qa1+tc+19019+user@mozy.com
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
    And I add a new user to a MozyEnterprise partner:
      | name             | email                       | enable stash |
      | TC.19012.1 user  | qa1+tc+19012+user1@mozy.com | yes          |
    Then New user should be created
    When I refresh Add New User section
    And I add a new user to a MozyEnterprise partner:
      | name             | email                       |
      | TC.19012.2 user  | qa1+tc+19012+user2@mozy.com |
    Then New user should be created
    When I refresh Add New User section
    And I add a new user to a MozyEnterprise partner:
      | name             | email                       |
      | TC.19012.3 user  | qa1+tc+19012+user3@mozy.com |
    Then New user should be created
    When I navigate to List User Groups section from bus admin console page
    And I view (default user group) * user group details
    And I enable stash for all users
    Then Popup window message should be Do you want to create a Stash for all 2 users with 20 GB total Desktop storage assigned for Stash usage?
    When I click Continue button on popup window
    And I refresh User Group Details section
    Then User group users list details should be:
    | External ID | User                        | Name            | Stash   | Machines | Storage | Storage Used | Created | Backed Up |
    |             | qa1+tc+19012+user3@mozy.com | TC.19012.3 user | Enabled | 0        | 10 GB   | none         | today   | never     |
    |             | qa1+tc+19012+user2@mozy.com | TC.19012.2 user | Enabled | 0        | 10 GB   | none         | today   | never     |
    |             | qa1+tc+19012+user1@mozy.com | TC.19012.1 user | Enabled | 0        | 10 GB   | none         | today   | never     |
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
    And I add a new user to a MozyEnterprise partner:
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
    And I add a new user to a Reseller partner:
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
    When I add a new user to a MozyEnterprise partner:
      | name           | email                       | user group     | enable stash |
      | TC.19118 user  | qa1+tc+19118+user1@mozy.com | TC.19118 group | yes          |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    Then user search results should be:
      |External ID | User                        | Name          | User Group      | Stash   | Machines | Storage | Storage Used | Created | Backed Up |
      |            | qa1+tc+19118+user1@mozy.com | TC.19118 user | TC.19118 group  | Enabled | 0        | 2 GB    | none         | today   | never     |
    When I search and delete TC.19118 group user group
    And I refresh Search List User section
    Then user search results should be:
      |External ID | User                        | Name          | User Group           | Stash   | Machines | Storage | Storage Used | Created | Backed Up |
      |            | qa1+tc+19118+user1@mozy.com | TC.19118 user | (default user group) | Enabled | 0        | 2 GB    | none         | today   | never     |
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
    When I add a new user to a MozyEnterprise partner:
      | name           | email                       | user group     | enable stash |
      | TC.19020 user  | qa1+tc+19020+user1@mozy.com | TC.19020 group | yes          |
    Then New user should be created
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | External ID | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota              | Desktop Keys | Desktop Quota              |
      |             | (default user group) * | 0     | 1      | 0           | 0 / 0       | 0.0 (0.0 assigned) / 0.0  | 0 / 8        | 0.0 (0.0 assigned) / 230.0 |
      |             | TC.19020 group         | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 assigned) / 0.0  | 0 / 2        | 0.0 (10.0 assigned) / 20.0 |
    When I search and delete TC.19020 group user group
    And I refresh Search List User section
    Then User groups list table should be:
      | External ID | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota              | Desktop Keys | Desktop Quota                |
      |             | (default user group) * | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 assigned) / 0.0  | 0 / 10       | 0.0 (10.0 assigned) / 250.0  |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name