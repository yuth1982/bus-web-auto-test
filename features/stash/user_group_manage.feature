Feature: User group stash setting management

  As a Mozy customer admin
  I want to turn-on Sync for a new user group
  so that I can add Sync to the users within that group

  Background:
    Given I log in bus admin console as administrator

  @TC.19001 @BSA.2000 @bus @stash
  Scenario: 19001 Add default stash storage for a new user group when stash is enabled for partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add a new Itemized user group:
      | name           | desktop_storage_type | desktop_devices | enable_stash |
      | TC.19001 group | Shared               | 5               | yes          |
    Then TC.19001 group user group should be created
    And I add new user(s):
      | name            | user_group     | storage_type | devices |
      | TC.19001.1-user | TC.19001 group | Desktop      | 1       |
    Then 1 new user should be created
    When I view details of TC.19001.1-user's user group
    Then User group details should be:
      | Enable Sync: |
      | Yes (change)  |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19004 @BSA.2000 @bus @stash
  Scenario: 19004 Add custom stash storage for a new user group when stash is enabled for partner
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 12     | 10    | yes       |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add a new Itemized user group:
      | name           | desktop_storage_type | desktop_devices | enable_stash |
      | TC.19004 group | Shared               | 5               | yes          |
    Then TC.19004 group user group should be created
    And I add new user(s):
      | name            | user_group     | storage_type | devices |
      | TC.19004.1-user | TC.19004 group | Desktop      | 1       |
    Then 1 new user should be created
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices |
      | Test | Shared               | 5               |
    Then Test user group should be created
    When I view details of TC.19004.1-user's user group
    Then User group details should be:
      | Enable Sync: |
      | Yes (change)  |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19005 @BSA.2010 @bus @stash
  Scenario: 19005 No Enable Sync settings in user group edit page when stash is disabled for partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    And I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | devices |
      | TC.19005.1-user | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    And I add a new Bundled user group:
      | name | storage_type |
      | Test | Shared       |
    Then Test user group should be created
    When I view details of TC.19005.1-user's user group
    Then I should not see Enable Sync text on user group details section
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19006 @BSA.2010 @bus @stash
  Scenario: 19006 Existing user groups are enabled when stash is enabled for partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Gold          | 100            |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    When I navigate to User Group List section from bus admin console page
    And Bundled user groups table should be:
        | Group Name            | Sync | Server | Storage Type | Type Value | Storage Used | Devices Used |
        | (default user group)  | true  | false  | Shared       |            | 0            | 0            |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19007 @BSA.2010 @bus @stash
  Scenario: 19007 Modify default stash storage quota for a user group in user group edit page when stash is enabled for partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Platinum      | 100            |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | devices | enable_stash |
      | TC.19007.1-user | (default user group) | Desktop      | 1       | yes          |
    Then 1 new user should be created
    And I add a new Bundled user group:
      | name | storage_type |
      | Test | Shared       |
    Then Test user group should be created
    When I view details of TC.19007.1-user's user group
    And I enable stash for the user group
    Then User group details should be:
      | Enable Sync: |
      | Yes (change)  |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19008 @BSA.2020 @bus @stash
  Scenario: 19008 Disable stash for a user group in user group detail section
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | devices | enable_stash |
      | TC.19008.1-user | (default user group) | Desktop      | 1       | yes          |
    Then 1 new user should be created
    When I navigate to User Group List section from bus admin console page
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total |
      | (default user group) | true  | Shared               |                    | 0                    | 0                    | 10                    |
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices |
      | Test | Shared               | 5               |
    Then Test user group should be created
    When I view details of TC.19008.1-user's user group
    And I disable stash for the user group
    Then User group details should be:
      | Enable Sync: |
      | No (change)   |
    When I navigate to User Group List section from bus admin console page
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total |
      | (default user group) | false | Shared               |                    | 0                    | 0                    | 5                     |
      | Test                 | false | Shared               |                    | 0                    | 0                    | 5                     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19009 @BSA.2020 @bus @stash
  Scenario: 19009 Cancel disable stash for a user group in user group detail section
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | devices | enable_stash |
      | TC.19009.1-user | (default user group) | Desktop      | 1       | yes          |
    Then 1 new user should be created
    When I navigate to User Group List section from bus admin console page
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total |
      | (default user group) | true  | Shared               |                    | 0                    | 0                    | 10                    |
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices |
      | Test | Shared               | 5               |
    Then Test user group should be created
    When I view details of TC.19009.1-user's user group
    And I cancel disable stash for the user group
    Then User group details should be:
      | Enable Sync: |
      | Yes (change)  |
    When I navigate to User Group List section from bus admin console page
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total |
      | (default user group) | true  | Shared               |                    | 0                    | 0                    | 5                     |
      | Test                 | false | Shared               |                    | 0                    | 0                    | 5                     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19010 @BSA.2020 @bus @stash
  Scenario: 19010 User has not stash when disable stash for a user group in user group detail section
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | devices | enable_stash |
      | TC.19010.1-user | (default user group) | Desktop      | 1       | yes          |
    Then 1 new user should be created
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices |
      | Test | Shared               | 5               |
    Then Test user group should be created
    When I view details of TC.19010.1-user's user group
    And I disable stash for the user group
    And I refresh User Details section
    Then I should not see Enable Sync: setting on user details section
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19011 @BSA.2030 @bus @stash
  Scenario: 19011 Add stash to all users for 0 user in the user group when stash is enabled for partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I try to add stash to all users for the partner
    Then Popup window message should be Nothing got changed. All users in this partner already have Sync.
    And I click Close button on popup window
    And I search and delete partner account by newly created partner company name

  @TC.19012 @BSA.2030 @bus @stash
  Scenario: 19012 A user is enabled with stash I can enable stash for other 2 users in the user group at once
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | devices | enable_stash |
      | TC.19012.1-user | (default user group) | Desktop      | 1       | yes          |
    Then 1 new user should be created
    And I add new user(s):
      | name            | user_group           | storage_type | devices | enable_stash |
      | TC.19012.2-user | (default user group) | Desktop      | 1       | no           |
      | TC.19012.3-user | (default user group) | Desktop      | 1       | no           |
    Then 2 new user should be created
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices |
      | Test | Shared               | 5               |
    Then Test user group should be created
    When I view details of TC.19012.1-user's user group
    And I enable stash for all users
    Then Popup window message should be Do you want to create a Sync for all 2 users?
    When I click Continue button on popup window
    And I refresh User Group Details section
    Then User group users list details should be:
    | Name            | Sync   | Machines | Storage         | Storage Used  |
    | TC.19012.3-user | Enabled | 0        | Desktop: Shared | Desktop: None |
    | TC.19012.2-user | Enabled | 0        | Desktop: Shared | Desktop: None |
    | TC.19012.1-user | Enabled | 0        | Desktop: Shared | Desktop: None |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18997 @BSA.3030 @bus @2.5 @user_stories
  Scenario: 18997 [List User Groups View][P]"Sync Users" column shows and has valid values
    When I act as partner by:
      | email                        |
      | test3010_3030_3040@auto.com  |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Sync Users |
      | (default user group) * | 2     | 1      | 1           |
      | backup                 | 1     | 1      | 0           |
      | stash                  | 1     | 1      | 1           |

  @TC.18998 @BSA.3030 @bus @2.5 @user_stories
  Scenario: 18998 [List User Groups View][P]"Desktop Quota" column includes backup and stash
    When I act as partner by:
      | email                        |
      | test3010_3030_3040@auto.com  |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Sync Users | Server Keys | Server Quota           | Desktop Keys | Desktop Quota             |
      | (default user group) * | 2     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 1 / 9        | 0.03 (3.0 active) / 230.0 |
      | backup                 | 1     | 1      | 0           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 1 / 10       | 0.01 (1.0 active) / 10.0  |
      | stash                  | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 0 / 0        | 0.02 (2.0 active) / 10.0  |

  @TC.18999 @BSA.3030 @bus @2.5 @user_stories
  Scenario: 18999 [Group Detail View][P]"Sync" column shows and has valid value
    When I act as partner by:
      | email                        |
      | test3010_3030_3040@auto.com  |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Sync Users | Server Keys | Server Quota           | Desktop Keys | Desktop Quota             |
      | (default user group) * | 2     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 1 / 9        | 0.03 (3.0 active) / 230.0 |
      | backup                 | 1     | 1      | 0           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 1 / 10       | 0.01 (1.0 active) / 10.0  |
      | stash                  | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 0 / 0        | 0.02 (2.0 active) / 10.0  |
    When I view (default user group) * user group details
    Then User group users list details should be:
      | User                 | Name        | Sync    |
      | stash19045@test.com  | stash19045  | Enabled  |
      | backup19045@test.com | backup19045 | Disabled |
    And I close the user group detail page
    When I view stash user group details
    Then User group users list details should be:
      | User            | Name  | Sync    |
      | stash@test.com  | stash | Enabled  |
    And I close the user group detail page
    When I view backup user group details
    Then User group users list details should be:
      | User            | Name   | Sync    |
      | backup@test.com | backup | Disabled |

  @TC.19000 @BSA.3030 @bus @2.5 @user_stories
  Scenario: 19000 [Group Detail View][P]"Storage" and "Storage Used" column includes backup and stash
    When I act as partner by:
      | email                        |
      | test3010_3030_3040@auto.com  |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Sync Users | Server Keys | Server Quota           | Desktop Keys | Desktop Quota             |
      | (default user group) * | 2     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 1 / 9        | 0.03 (3.0 active) / 230.0 |
      | backup                 | 1     | 1      | 0           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 1 / 10       | 0.01 (1.0 active) / 10.0  |
      | stash                  | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 0 / 0        | 0.02 (2.0 active) / 10.0  |
    When I view (default user group) * user group details
    Then User group users list details should be:
      | User                 | Name        | Sync    | Machines | Storage | Storage Used |
      | stash19045@test.com  | stash19045  | Enabled  | 0        | 2 GB    | 20 MB        |
      | backup19045@test.com | backup19045 | Disabled | 1        | 1 GB    | 10 MB        |
    And I close the user group detail page
    When I view stash user group details
    Then User group users list details should be:
      | User            | Name  | Sync    | Machines | Storage | Storage Used |
      | stash@test.com  | stash | Enabled  | 0        | 2 GB    | 20 MB        |
    And I close the user group detail page
    When I view backup user group details
    Then User group users list details should be:
      | User            | Name   | Sync    | Machines | Storage | Storage Used |
      | backup@test.com | backup | Disabled | 1        | 1 GB    | 10 MB        |
