Feature:
  Provision a Stash container for each user when the admin gives Stash to the user via:
  allocating/assigning Stash storage to the user, or through a bulk add for the user group.

  Background:
    Given I log in bus admin console as administrator

# Dup
#  @TC.19039 @BSA.1000
#  Scenario: 19039 MozyPro Partner Verify Stash UI in Add New User
#    When I add a new MozyPro partner:
#      | period | base plan | server plan |
#      | 12     | 100 GB    | yes         |
#    Then New partner should be created
#    When I enable stash for the partner with default stash storage
#    Then Partner general information should be:
#      | Enable Stash: | Default Stash Storage: |
#      | Yes           | 2 GB (change)          |
#    When I act as newly created partner account
#    And I add a new user to a MozyPro partner:
#      | name | email  | enable stash |
#      |      |        | no           |
#    Then New user created message should be Please input all required fields and at least one User Name and Email
#    And I refresh Add New User section
#    When I add a new user to a MozyPro partner:
#      | name          | desired_user_storage | device_count |
#      | TC.19039 user | 9999999999           | 9999999999   |
#    Then New user created message should be User Group (default user group) does not have enough storage available.
#    And I refresh Add New User section
#    When I add a new user to a MozyPro partner:
#      | name          | email | desired_user_storage | device_count | enable stash |
#      | TC.19039 user |       | 20                   | 1            | yes          |
#    Then New user created message should be Please input all required fields and at least one User Name and Email
#    When I stop masquerading
#    And I search and delete partner account by newly created partner company name

  @TC.19040 @BSA.1000
  Scenario: 19040 MozyPro Partner Provision Stash Container - Default User Group no email invite
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    Then New partner should be created
    When I enable stash for the partner
    And I act as newly created partner account
    And I add new user(s):
      | name          | storage_type | storage_limit | devices | enable_stash | send_email |
      | TC.19040 User | Desktop      | 10            | 1       | yes          | no         |
    Then 1 new user should be created
    When I search emails by keywords:
      | to              | subject      |
      | @new_user_email | enable stash |
    Then I should see 0 email(s)
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User          | Name          | Stash   | Machines | Storage        | Storage Used |
      | @user_email   | TC.19040 User | Enabled | 0        | 10 GB(Limited) | None         |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Stash:               |
      | TC.19040 User (change) | Yes (Send Invitation Email) |
    And stash device table in user details should be:
      | Stash Container | Used/Available     | Device Storage Limit | Last Update      |
      | Stash           | 0 / 10 GB          | Set                  | N/A              |
    When I navigate to Search / List Machines section from bus admin console page
    Then Machine search results should be:
      | Machine | User                        | User Group           | Data Center | Storage Used |
      | Stash   | <%=@new_users.first.email%> | (default user group) | qa6         | 0            |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And Partner stash info should be:
      | Stash Users:         | 1 |
      | Stash Storage Usage: | 0 |
    And I delete partner account

  @TC.19044 @BSA.1000
  Scenario: 19044 MozyPro Partner Provision Stash Container - Default User Group with email invite
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    Then New partner should be created
    When I enable stash for the partner
    And I act as newly created partner account
    And I add new user(s):
      | name          | storage_type | storage_limit | devices | enable_stash | send_email |
      | TC.19040 User | Desktop      | 10            | 1       | yes          | no         |
    Then 1 new user should be created


    And I add a new user to a MozyPro partner:
      | name           | enable stash | stash quota | send stash invite |
      | TC.19044 user  | yes          | 5           | yes               |
    Then New user should be created
    When I search emails by keywords:
      | to              | subject      |
      | @new_user_email | enable stash |
    Then I should see 1 email(s)
    When I navigate to Search / List Users section from bus admin console page
    Then user search results should be:
      | User            | Name           | Stash   | Machines | Storage | Storage Used | Created | Backed Up |
      | @new_user_email | TC.19044 user  | Enabled | 0        | 5 GB    | none         | today   | never     |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Stash:               |
      | TC.19044 user (change) | Yes (Send Invitation Email) |
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I navigate to Search / List Machines section from bus admin console page
    Then Machine search results should be:
      | User Group           | Data Center | Storage Used            |
      | (default user group) | qa6         | 0 bytes / 5 GB (change) |
    When I navigate to Manage Resources section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 0 bytes / 5 GB       |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 1              |
      | Stash Storage Usage: | 0 bytes / 5 GB |
    And I delete partner account

  @TC.19078 @BSA.1000
  Scenario: 19078 MozyPro Partner Add Stash to existing partner
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    Then I should not see stash options
    When I add a new user to a MozyPro partner:
      | name          | desktop licenses | desktop quota |
      | TC.19078 user | 1                | 10            |
    Then New user should be created
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    When I enable stash for the partner with 5 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 5 GB (change)          |
    When I act as newly created partner account
    And I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | user            | Name           | Stash   | Machines | Storage | Storage Used | Created | Backed Up |
      | @new_user_email | TC.19078 user  | Disabled | 0       | 0 bytes | none         | today   | never     |
    And I view user details by newly created user email
    Then User details should be:
      | Name:                  | Enable Stash:  |
      | TC.19078 user (change) | No (Add Stash) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19079 @BSA.1000

  Scenario: 19079 MozyPro Partner Add Stash container that exceeds available Stash quota
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyPro partner:
      | name           |
      | TC.19079 user  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I add stash for the user with:
      | stash quota | send email |
      | 9999999     | no         |
    Then Popup window message should be You do not have enough storage available for the default storage entered. Use the Manage Resources panel to increase the amount of storage allocated or to purchase more storage.
    When I click Allocate button on popup window
    Then Manage Resources section should be visible
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I add stash for the user with:
      | stash quota | send email |
      | 9999999     | no         |
    And I click Buy More button on popup window
    Then Change Plan section should be visible
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I add stash for the user with:
      | stash quota | send email |
      | 9999999     | no         |
    Then I close popup window
    When  I refresh Search List User section
    Then User search results should be:
      | User | Name     | Stash   | Machines | Storage | Storage Used | Created | Backed Up |
      | @new_user_email | TC.19079 user  | Disabled | 0       | 0 bytes | none         | today   | never     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19080 @BSA.1000
  Scenario: 19080 MozyPro Partner Add Stash Container Default User Group No Email
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyPro partner:
      | name           |
      | TC.19080 user  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I add stash for the user with:
      | stash quota | send email |
      | 5           | no         |
    Then user details should be:
      | Name:                  | Enable Stash:               |
      | TC.19080 user (change) | Yes (Send Invitation Email) |
    When I search emails by keywords:
      | to              | subject      |
      | @new_user_email | enable stash |
    Then I should see 0 email(s)
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User            | Name           | Stash   | Machines | Storage | Storage Used |
      | @new_user_email | TC.19080 user  | Enabled | 0        | 5 GB    | none         |
    When I navigate to Manage Resources section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 0 bytes / 5 GB       |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 1              |
      | Stash Storage Usage: | 0 bytes / 5 GB |
    And I delete partner account

  @TC.19082 @BSA.1000

  Scenario: 19082 MozyPro Partner Edit Stash Container - Default User Group No Email
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyPro partner:
      | name           | enable stash | stash quota |
      | TC.19082 user  | yes          | 5           |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I cancel change user stash quota
    Then User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I click change stash quota text box
    Then Change stash quota hover message should be Max: 100 GB
    When I refresh User Details section
    And I change user stash quota to 999999999 GB
    Then Popup window message should be You do not have enough storage available for the default storage entered. Use the Manage Resources panel to increase the amount of storage allocated or to purchase more storage.
    And I close popup window
    When I refresh User Details section
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I change user stash quota to 10 GB
    Then User stash quota changed successfully
    And User backup details table should be:
      | Computer | Encryption | Storage Used             | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 10 GB (change) | N/A         |             | delete  |
    When I navigate to Manage Resources section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 0 bytes / 10 GB      |
    And Partner total resources details table should be:
      |         | Active    | Assigned | Unassigned | Allocated       |
      | Desktop | 10 GB     | 0 bytes  | 90 GB      | 100 GB   Change |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 1               |
      | Stash Storage Usage: | 0 bytes / 10 GB |
    And I delete partner account

  @TC.19084 @BSA.1000
  Scenario: 19084 MozyPro Partner Delete Stash container using the Delete link
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyPro partner:
      | name          | enable stash | stash quota |
      | TC.19084 user | yes          | 5           |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I delete stash container for the user
    Then Popup window message should be Do you want to delete the user's stash? Note: Deleting a user's Stash removes all of the user's Stash files from the Web.
    And I click Cancel button on popup window
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I delete stash container for the user
    Then I click Continue button on popup window
    And User backup details table should not have stash record
    When I refresh Search List User section
    Then User search results should be:
      | User            | Name           | Stash    | Machines | Storage | Storage Used |
      | @new_user_eamil | TC.19084 user  | Disabled | 0        | 0 bytes | none         |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 0                 |
      | Stash Storage Usage: | 0 bytes / 0 bytes |
    And I delete partner account

  @TC.18993 @BSA.1000
  Scenario: 18993 Reseller Partner Verify Stash UI in Add New User
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 100            | yes         |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    When I allocate 50 GB Desktop quota with (default user group) user group to Reseller partner
    Then Reseller resource quota should be changed
    And I refresh Manage User Group Resources section
    When I allocate 30 GB Server quota with (default user group) user group to Reseller partner
    Then Reseller resource quota should be changed
    When I create 10 new Desktop keys for Reseller partner
    Then Reseller resource keys should be created
    And I refresh Manage User Group Resources section
    When I create 5 new Server keys for Reseller partner
    Then Reseller resource keys should be created
    And I add a new user to a Reseller partner:
      | name | email  | enable stash |
      |      |        | no           |
    Then New user created message should be Please enter a valid email address
    And I refresh Add New User section
    When I add a new user to a Reseller partner:
      | name          | desktop licenses | desktop quota | server licenses | server quota |
      | TC.18993 user | 9999999999       | 9999999999    | 9999999999      | 9999999999   |
    Then New user created message should be Only 50 Desktop GB free Only 5 Server licenses available. Only 10 Desktop licenses available. Only 30 Server GB free
    And I refresh Add New User section
    When I add a new user to a Reseller partner:
      | name          | enable stash | stash quota |
      | TC.18993 user | yes          | 99999999999 |
    Then New user created message should be Only 50 Desktop GB free
    When I add a new user to a Reseller partner:
      | name          | email | desktop licenses | desktop quota | enable stash | stash quota |
      | TC.18993 user |       | 1                | 20            | yes          | 5           |
    Then New user created message should be Please enter a valid email address
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18994 @BSA.1000
  Scenario: 18994 Reseller Partner Provision Stash Container - Default User Group no email invite
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    When I allocate 50 GB Desktop quota with (default user group) user group to Reseller partner
    Then Reseller resource quota should be changed
    When I create 10 new Desktop keys for Reseller partner
    Then Reseller resource keys should be created
    And I add a new user to a Reseller partner:
      | name          | enable stash | stash quota |
      | TC.18994 user | yes          | 5           |
    Then New user should be created
    When I search emails by keywords:
      | to              | subject      |
      | @new_user_email | enable stash |
    Then I should see 0 email(s)
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User            | Name           | User Group           | Stash   | Machines | Storage | Storage Used |
      | @new_user_email | TC.18994 user  | (default user group) | Enabled | 0        | 5 GB    | none         |
    When I view user details by newly created user email
    Then User details should be:
      | Name:                  | Enable Stash:               |
      | TC.18994 user (change) | Yes (Send Invitation Email) |
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I navigate to Search / List Machines section from bus admin console page
    Then Machine search results should be:
      | Machine | User            | User Group           | Data Center | Storage Used            |
      | Stash   | @new_user_email | (default user group) | qa6         | 0 bytes / 5 GB (change) |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Keys   | Quota                      |
      | (default user group) * | 1     | 1      | 1           | 0 / 10 | 0.0 (5.0 assigned) / 50.0  |
    When I view (default user group) * user group details
    Then User group users list details should be:
      | Name          | Stash   | Machines | Storage | Storage Used |
      | TC.18994 user | Enabled | 0        | 5 GB    | none         |
    When I navigate to Manage Resources section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 0 bytes / 5 GB       |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 1              |
      | Stash Storage Usage: | 0 bytes / 5 GB |
    And I delete partner account

  @TC.19022 @BSA.1000
  Scenario: 19022 Reseller Partner Provision Stash Container - Custom User Group with email invite
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     | Silver        | 100            | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    When I add a new user group:
      | name           | stash quota |
      | TC.19022 group | 5           |
    Then New user group should be created
    When I allocate 50 GB Desktop quota with TC.19022 group user group to Reseller partner
    Then Reseller resource quota should be changed
    When I create 10 new Desktop keys for Reseller partner
    Then Reseller resource keys should be created
    And I add a new user to a Reseller partner:
      | name          | user group     | enable stash | send stash invite |
      | TC.19022 user | TC.19022 group | yes          | yes               |
    Then New user should be created
    When I search emails by keywords:
      | to              | subject      |
      | @new_user_email | enable stash |
    Then I should see 1 email(s)
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User            | Name           | User Group     | Stash   | Machines | Storage | Storage Used | Created | Backed Up |
      | @new_user_email | TC.19022 user  | TC.19022 group | Enabled | 0        | 5 GB    | none         | today   | never     |
    When I view user details by newly created user email
    Then User details should be:
      | Name:                  | Enable Stash:               |
      | TC.19022 user (change) | Yes (Send Invitation Email) |
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I navigate to Search / List Machines section from bus admin console page
    Then Machine search results should be:
      | Machine | User            | User Group     | Data Center | Storage Used            | Created |
      | Stash   | @new_user_email | TC.19022 group | qa6         | 0 bytes / 5 GB (change) | today   |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Keys   | Quota                    |
      | (default user group) * | 0     | 1      | 0           | 0 / 0  | 0.0 (0.0 active) / 0.0   |
      | TC.19022 group         | 1     | 1      | 1           | 0 / 10 | 0.0 (5.0 active) / 50.0  |
    When I view TC.19022 group user group details
    Then User group users list details should be:
      | Name          | Stash   | Machines | Storage | Storage Used | Created | Backed Up |
      | TC.19022 user | Enabled | 0        | 5 GB    | none         | today   | never     |
    When I navigate to Manage Resources section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 0 bytes / 5 GB       |
    And Partner user groups table should be:
      | Name                  | Active Storage | Allocated Storage |
      | (default user group)  | 0 GB           | 0 GB              |
      | TC.19022 group        | 5 GB           | 50 GB             |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 1              |
      | Stash Storage Usage: | 0 bytes / 5 GB |
    And I delete partner account

  @TC.18967 @BSA.1000
  Scenario: 18967 Reseller Partner Add Stash to existing partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    And I allocate 50 GB Desktop quota with (default user group) user group to Reseller partner
    Then Reseller resource quota should be changed
    When I create 10 new Desktop keys for Reseller partner
    Then Reseller resource keys should be created
    And I navigate to Add New User section from bus admin console page
    Then I should not see stash options
    When I add a new user to a Reseller partner:
      | name           | desktop licenses | desktop quota |
      | TC.18967 user1 | 1                | 6             |
    Then New user should be created
    When I add a new user to a Reseller partner:
      | name           | desktop licenses | desktop quota |
      | TC.18967 user2 | 1                | 6             |
    Then New user should be created
    When I add a new user to a Reseller partner:
      | name           | desktop licenses | desktop quota |
      | TC.18967 user3 | 1                | 6             |
    Then New user should be created
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    When I enable stash for the partner with 5 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 5 GB (change)          |
    When I add stash to all users for the partner
    When I act as newly created partner account
    And I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User            | Name           | User Group           | Stash   | Machines | Storage |
      | @new_user_email | TC.18967 user3 | (default user group) | Enabled | 0        | 5 GB    |
      | @new_user_email | TC.18967 user2 | (default user group) | Enabled | 0        | 5 GB    |
      | @new_user_email | TC.18967 user1 | (default user group) | Enabled | 0        | 5 GB    |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18968 @BSA.1000
  Scenario: 18968 Reseller Partner Add Stash container that exceeds available Stash quota
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a Reseller partner:
      | name           |
      | TC.18968 user  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I add stash for the user with:
      | stash quota | send email |
      | 9999999     | no         |
    Then Popup window message should be You do not have enough storage available for the default storage entered. Use the Manage Resources panel to increase the amount of storage allocated or to purchase more storage.
    When I click Allocate button on popup window
    Then Manage Resources section should be visible
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I add stash for the user with:
      | stash quota | send email |
      | 9999999     | no         |
    And I click Buy More button on popup window
    Then Change Plan section should be visible
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I add stash for the user with:
      | stash quota | send email |
      | 9999999     | no         |
    Then I close popup window
    When I refresh Search List User section
    Then User search results should be:
      | User            | Name           | User Group           | Stash   | Machines | Storage |
      | @new_user_email | TC.18968 user  | (default user group) | Disabled | 0       | 0 bytes |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18969 @BSA.1000
  Scenario: 18969 Reseller Partner Add Stash Container Default User Group No Email
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I allocate 50 GB Desktop quota with (default user group) user group to Reseller partner
    Then Reseller resource quota should be changed
    When I create 5 new Desktop keys for Reseller partner
    Then Reseller resource keys should be created
    And I add a new user to a Reseller partner:
      | name           |
      | TC.18969 user  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I add stash for the user with:
      | stash quota | send email |
      | 5           | no         |
    Then user details should be:
      | Name:                  | Enable Stash:               |
      | TC.18969 user (change) | Yes (Send Invitation Email) |
    When I search emails by keywords:
      | to              | subject      |
      | @new_user_email | enable stash |
    Then I should see 0 email(s)
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User            | Name           | User Group           | Stash   | Machines | Storage | Storage Used |
      | @new_user_email | TC.18969 user  | (default user group) | Enabled | 0        | 5 GB    | none         |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Keys  | Quota                   |
      | (default user group) * | 1     | 1      | 1           | 0 / 5 | 0.0 (5.0 active) / 50.0 |
    And I view (default user group) * user group details
    Then User group details should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    Then User group users list details should be:
      | Name          | Stash   | Machines | Storage |
      | TC.18969 user | Enabled | 0        | 5 GB    |
    When I navigate to Manage Resources section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 0 bytes / 5 GB       |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 1              |
      | Stash Storage Usage: | 0 bytes / 5 GB |
    And I delete partner account

  @TC.19060 @BSA.1000
  Scenario: 19060 Reseller Partner Edit Stash Container - Default User Group No Email
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     | Silver        | 100            | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I allocate 50 GB Desktop quota with (default user group) user group to Reseller partner
    Then Reseller resource quota should be changed
    And I add a new user to a Reseller partner:
      | name           | enable stash | stash quota |
      | TC.19060 user  | yes          | 5           |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I cancel change user stash quota
    Then User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I click change stash quota text box
    Then Change stash quota hover message should be Max: 50 GB
    When I refresh User Details section
    And I change user stash quota to 999999999 GB
    Then Popup window message should be You do not have enough storage available for the default storage entered. Use the Manage Resources panel to increase the amount of storage allocated or to purchase more storage.
    And I close popup window
    When I refresh User Details section
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I change user stash quota to 10 GB
    Then User stash quota changed successfully
    And User backup details table should be:
      | Computer | Encryption | Storage Used             | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 10 GB (change) | N/A         |             | delete  |
    When I navigate to Manage Resources section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 0 bytes / 10 GB      |
    And Partner total resources details table should be:
      |         | Active    | Assigned | Unassigned | Allocated |
      | Desktop | 10 GB     | 0 bytes  | 40 GB      | 50 GB     |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 1               |
      | Stash Storage Usage: | 0 bytes / 10 GB |
    And I delete partner account

  @TC.18970 @BSA.1000
  Scenario: 18970 Reseller Partner Delete Stash container using the Delete link
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I allocate 50 GB Desktop quota with (default user group) user group to Reseller partner
    Then Reseller resource quota should be changed
    And I add a new user to a Reseller partner:
      | name           | enable stash | stash quota |
      | TC.18970 user  | yes          | 5           |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I delete stash container for the user
    Then Popup window message should be Do you want to delete the user's stash? Note: Deleting a user's Stash removes all of the user's Stash files from the Web.
    And I click Cancel button on popup window
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I delete stash container for the user
    Then I click Continue button on popup window
    And User backup details table should not have stash record
    When I refresh Search List User section
    Then User search results should be:
      | User            | Name           | User Group           | Stash    | Machines | Storage | Storage Used | Created | Backed Up |
      | @new_user_email | TC.18970 user  | (default user group) | Disabled | 0        | 0 bytes | none         | today   | never     |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 0                 |
      | Stash Storage Usage: | 0 bytes / 0 bytes |
    And I delete partner account

  @TC.19061 @BSA.1000
  Scenario: 19061 Reseller Partner Add Stash Container - Custom User Group with Email
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    When I add a new user group:
      | name           | stash quota |
      | TC.19061 group | 5           |
    Then New user group should be created
    When I allocate 50 GB Desktop quota with TC.19061 group user group to Reseller partner
    Then Reseller resource quota should be changed
    When I create 5 new Desktop keys for Reseller partner
    Then Reseller resource keys should be created
    And I add a new user to a Reseller partner:
      | name           | user group     | enable stash | send stash invite |
      | TC.19061 user  | TC.19061 group | yes          | yes               |
    Then New user should be created
    When I search emails by keywords:
      | to              | subject      |
      | @new_user_email | enable stash |
    Then I should see 1 email(s)
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User            | Name           | User Group     | Stash   | Machines | Storage | Storage Used |
      | @new_user_email | TC.19061 user  | TC.19061 group | Enabled | 0        | 5 GB    | none         |
    When I view user details by newly created user email
    Then User details should be:
      | Name:                  | Enable Stash:               |
      | TC.19061 user (change) | Yes (Send Invitation Email) |
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I navigate to Search / List Machines section from bus admin console page
    Then Machine search results should be:
      | Machine | User            | User Group     | Data Center | Storage Used            |
      | Stash   | @new_user_email | TC.19061 group | qa6         | 0 bytes / 5 GB (change) |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Keys   | Quota                    |
      | (default user group) * | 0     | 1      | 0           | 0 / 0  | 0.0 (0.0 active) / 0.0   |
      | TC.19061 group         | 1     | 1      | 1           | 0 / 5  | 0.0 (5.0 active) / 50.0  |
    When I view TC.19061 group user group details
    Then User group users list details should be:
      | Name          | Stash   | Machines | Storage | Storage Used |
      | TC.19061 user | Enabled | 0        | 5 GB    | none         |
    When I navigate to Manage Resources section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 0 bytes / 5 GB       |
    And Partner user groups table should be:
      | Name                  | Active Storage | Allocated Storage |
      | (default user group)  | 0 GB           | 0 GB              |
      | TC.19061 group        | 5 GB           | 50 GB             |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 1              |
      | Stash Storage Usage: | 0 bytes / 5 GB |
    And I delete partner account

  @TC.19063 @BSA.1000
  Scenario: 19063 Reseller Partner Edit Stash Container - Custom User Group No Email
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     | Silver        | 100            | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    When I add a new user group:
      | name           | stash quota |
      | TC.19063 group | 5           |
    Then New user group should be created
    When I allocate 50 GB Desktop quota with TC.19063 group user group to Reseller partner
    Then Reseller resource quota should be changed
    When I create 5 new Desktop keys for Reseller partner
    Then Reseller resource keys should be created
    And I add a new user to a Reseller partner:
      | name           | user group     | enable stash |
      | TC.19063 user  | TC.19063 group | yes          |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I cancel change user stash quota
    Then User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I click change stash quota text box
    Then Change stash quota hover message should be Max: 50 GB
    When I refresh User Details section
    And I change user stash quota to 999999999 GB
    Then Popup window message should be You do not have enough storage available for the default storage entered. Use the Manage Resources panel to increase the amount of storage allocated or to purchase more storage.
    And I close popup window
    When I refresh User Details section
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I change user stash quota to 10 GB
    Then User stash quota changed successfully
    And User backup details table should be:
      | Computer | Encryption | Storage Used             | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 10 GB (change) | N/A         |             | delete  |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Keys   | Quota                    |
      | (default user group) * | 0     | 1      | 0           | 0 / 0  | 0.0 (0.0 active) / 0.0   |
      | TC.19063 group         | 1     | 1      | 1           | 0 / 5  | 0.0 (10.0 active) / 50.0 |
    When I view TC.19063 group user group details
    Then User group users list details should be:
      | Name          | Stash   | Machines | Storage | Storage Used | Created | Backed Up |
      | TC.19063 user | Enabled | 0        | 10 GB   | none         | today   | never     |
    When I navigate to Manage Resources section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 0 bytes / 10 GB      |
    And Partner total resources details table should be:
      |         | Active    | Assigned | Unassigned | Allocated |
      | Desktop | 10 GB     | 0 bytes  | 40 GB      | 50 GB     |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 1               |
      | Stash Storage Usage: | 0 bytes / 10 GB |
    And I delete partner account

  @TC.19065 @BSA.1000
  Scenario: 19065 Reseller Partner Delete Stash container using the Delete link  - Custom User Group with Email
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     | Silver        | 100            | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    When I add a new user group:
      | name           | stash quota |
      | TC.19065 group | 5           |
    Then New user group should be created
    When I allocate 50 GB Desktop quota with TC.19065 group user group to Reseller partner
    Then Reseller resource quota should be changed
    When I create 5 new Desktop keys for Reseller partner
    Then Reseller resource keys should be created
    And I add a new user to a Reseller partner:
      | name           | user group     | enable stash |
      | TC.19065 user  | TC.19065 group | yes          |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I delete stash container for the user
    Then Popup window message should be Do you want to delete the user's stash? Note: Deleting a user's Stash removes all of the user's Stash files from the Web.
    And I click Cancel button on popup window
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I delete stash container for the user
    Then I click Continue button on popup window
    And User backup details table should not have stash record
    When I refresh Search List User section
    Then User search results should be:
      | User            | Name           | User Group     | Stash    | Machines | Storage | Storage Used |
      | @new_user_email | TC.19065 user  | TC.19065 group | Disabled | 0        | 0 bytes | none         |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Keys   | Quota                   |
      | (default user group) * | 0     | 1      | 0           | 0 / 0  | 0.0 (0.0 active) / 0.0  |
      | TC.19065 group         | 1     | 1      | 0           | 0 / 5  | 0.0 (0.0 active) / 50.0 |
    When I view TC.19065 group user group details
    Then User group users list details should be:
      | Name          | Stash    | Machines | Storage | Storage Used | Created | Backed Up |
      | TC.19065 user | Disabled | 0        | 0 bytes | none         | today   | never     |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 0                 |
      | Stash Storage Usage: | 0 bytes / 0 bytes |
    And I delete partner account

  @TC.19034 @BSA.1000
  Scenario: 19034 Reseller Partner Verify Stash UI in Add New User
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 50 GB       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a Reseller partner:
      | name | email  | enable stash |
      |      |        | no           |
    Then New user created message should be Please enter a valid email address
    And I refresh Add New User section
    When I add a new user to a Reseller partner:
      | name          | desktop licenses | desktop quota | server licenses | server quota |
      | TC.19034 user | 9999999999       | 9999999999    | 9999999999      | 9999999999   |
    Then New user created message should be Only 250 Desktop GB free Only 200 Server licenses available. Only 10 Desktop licenses available. Only 50 Server GB free
    And I refresh Add New User section
    When I add a new user to a Reseller partner:
      | name          | enable stash | stash quota |
      | TC.19034 user |  yes          | 99999999999 |
    Then New user created message should be Only 250 Desktop GB free
    When I add a new user to a Reseller partner:
      | name          | email | desktop licenses | desktop quota | enable stash | stash quota |
      | TC.19034 user |       | 1                | 20            | yes          | 5           |
    Then New user created message should be Please enter a valid email address
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19035 @BSA.1000
  Scenario: 19035 MozyEnterprise Partner Provision Stash Container - Default User Group no email invite
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyEnterprise partner:
      | name           | enable stash | stash quota |
      | TC.19035 user  | yes          | 5           |
    Then New user should be created
    When I search emails by keywords:
      | to              | subject      |
      | @new_user_email | enable stash |
    Then I should see 0 email(s)
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User            | Name           | User Group           | Stash   | Machines | Storage | Storage Used |
      | @new_user_email | TC.19035 user  | (default user group) | Enabled | 0        | 5 GB    | none         |
    When I view user details by newly created user email
    Then User details should be:
      | Name:                  | Enable Stash:               |
      | TC.19035 user (change) | Yes (Send Invitation Email) |
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I navigate to Search / List Machines section from bus admin console page
    Then Machine search results should be:
      | Machine | User            | User Group           | Data Center | Storage Used            |
      | Stash   | @new_user_email | (default user group) | qa6         | 0 bytes / 5 GB (change) |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota             | Desktop Keys | Desktop Quota            |
      | (default user group) * | 1     | 1      | 1           | 0 / 200     | 0.0 (0.0 active) / 100.0 | 0 / 10       | 0.0 (5.0 active) / 250.0 |
    When I view (default user group) * user group details
    Then User group users list details should be:
      | Name          | Stash   | Machines | Storage | Storage Used |
      | TC.19035 user | Enabled | 0        | 5 GB    | none         |
    When I navigate to Assign Keys section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 0 bytes / 5 GB       |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 1              |
      | Stash Storage Usage: | 0 bytes / 5 GB |
    And I delete partner account

  @TC.19037 @BSA.1000
  Scenario: 19037 MozyEnterprise Partner Provision Stash Container - Custom User Group with email invite
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 100 GB      |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    When I add a new user group:
      | name           | stash quota |
      | TC.19037 group | 5           |
    Then New user group should be created
    When I transfer resources from (default user group) to TC.19037 group with:
      | server licenses | server quota GB | desktop licenses | desktop quota GB |
      | 1               | 10              | 2                | 30               |
    Then Resources should be transferred
    When I add a new user to a MozyEnterprise partner:
        | name           | user group     | enable stash | send stash invite |
        | TC.19037 user  | TC.19037 group | yes          | yes               |
    Then New user should be created
    When I search emails by keywords:
      | to              | subject      |
      | @new_user_email | enable stash |
    Then I should see 1 email(s)
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User            | Name           | User Group     | Stash   | Machines | Storage | Storage Used |
      | @new_user_email | TC.19037 user  | TC.19037 group | Enabled | 0        | 5 GB    | none         |
    When I view user details by newly created user email
    Then User details should be:
      | Name:                  | Enable Stash:               |
      | TC.19037 user (change) | Yes (Send Invitation Email) |
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I navigate to Search / List Machines section from bus admin console page
    Then Machine search results should be:
      | Machine | User            | User Group     | Data Center | Storage Used            |
      | Stash   | @new_user_email | TC.19037 group | qa6         | 0 bytes / 5 GB (change) |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota            | Desktop Keys | Desktop Quota            |
      | (default user group) * | 0     | 1      | 0           | 0 / 199     | 0.0 (0.0 active) / 90.0 | 0 / 8        | 0.0 (0.0 active) / 220.0 |
      | TC.19037 group         | 1     | 1      | 1           | 0 / 1       | 0.0 (0.0 active) / 10.0 | 0 / 2        | 0.0 (5.0 active) / 30.0  |
    When I view TC.19037 group user group details
    Then User group users list details should be:
      | Name          | Stash   | Machines | Storage | Storage Used |
      | TC.19037 user | Enabled | 0        | 5 GB    | none         |
    When I navigate to Assign Keys section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 0 bytes / 5 GB       |
    And Partner user groups table should be:
      | Name                  | Active Storage | Allocated Storage |
      | (default user group)  | 0 GB           | 310 GB            |
      | TC.19037 group        | 5 GB           | 40 GB             |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 1              |
      | Stash Storage Usage: | 0 bytes / 5 GB |
    And I delete partner account

  @TC.19102 @BSA.1000
  Scenario: 19102 MozyEnterprise Partner Add Stash to existing partner
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I act as newly created partner account
    When I navigate to Add New User section from bus admin console page
    Then I should not see stash options
    When I add a new user to a MozyEnterprise partner:
      | name           | desktop licenses | desktop quota |
      | TC.19102 user1 | 1                | 15            |
    Then New user should be created
    When I add a new user to a MozyEnterprise partner:
      | name           | desktop licenses | desktop quota |
      | TC.19102 user2 | 1                | 15            |
    Then New user should be created
    When I add a new user to a MozyEnterprise partner:
      | name           | server licenses  | server quota  |
      | TC.19102 user3 | 1                | 10            |
    Then New user should be created
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    When I enable stash for the partner with 5 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 5 GB (change)          |
    When I add stash to all users for the partner
    When I act as newly created partner account
    And I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User            | Name           | User Group           | Stash   | Machines | Storage | Storage Used |
      | @new_user_email | TC.19102 user3 | (default user group) | Enabled | 0        | 5 GB    | none         |
      | @new_user_email | TC.19102 user2 | (default user group) | Enabled | 0        | 5 GB    | none         |
      | @new_user_email | TC.19102 user1 | (default user group) | Enabled | 0        | 5 GB    | none         |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19103 @BSA.1000
  Scenario: 19103 MozyEnterprise Partner Add Stash container that exceeds available Stash quota
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 12     | 10    | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyEnterprise partner:
      | name           |
      | TC.19103 user  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I add stash for the user with:
      | stash quota | send email |
      | 9999999     | no         |
    And I click Buy More button on popup window
    Then Change Plan section should be visible
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I add stash for the user with:
      | stash quota | send email |
      | 9999999     | no         |
    Then I close popup window
    When I refresh Search List User section
    Then User search results should be:
      | User            | Name           | User Group           | Stash    | Machines | Storage | Storage Used |
      | @new_user_email | TC.19103 user  | (default user group) | Disabled | 0        | 0 bytes | none         |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19104 @BSA.1000
  Scenario: 19104 Reseller Partner Add Stash Container Default User Group No Email - Part I and II
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a Reseller partner:
      | name           |
      | TC.19104 user  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I add stash for the user with:
      | stash quota | send email |
      | 5           | no         |
    Then user details should be:
      | Name:                  | Enable Stash:               |
      | TC.19104 user (change) | Yes (Send Invitation Email) |
    When I search emails by keywords:
      | to              | subject      |
      | @new_user_email | enable stash |
    Then I should see 0 email(s)
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User            | Name           | User Group           | Stash   | Machines | Storage | Storage Used |
      | @new_user_email | TC.19104 user  | (default user group) | Enabled | 0        | 5 GB    | none         |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota           | Desktop Keys | Desktop Quota            |
      | (default user group) * | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 0 / 10       | 0.0 (5.0 active) / 250.0 |
    And I view (default user group) * user group details
    Then User group details should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    Then User group users list details should be:
      | Name          | Stash   | Machines | Storage | Storage Used |
      | TC.19104 user | Enabled | 0        | 5 GB    | none         |
    When I navigate to Assign Keys section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 0 bytes / 5 GB       |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 1              |
      | Stash Storage Usage: | 0 bytes / 5 GB |
    And I delete partner account

  @TC.19106 @BSA.1000
  Scenario: 19106 MozyEnterprise Partner Edit Stash Container - Default User Group No Email
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 12     | 10    | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyEnterprise partner:
      | name           | enable stash | stash quota |
      | TC.19106 user  | yes          | 5           |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I cancel change user stash quota
    Then User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I click change stash quota text box
    Then Change stash quota hover message should be Max: 250 GB
    When I refresh User Details section
    And I change user stash quota to 999999999 GB
    Then Popup window message should be There is not enough storage available to add the default storage amount.
    And I close popup window
    When I refresh User Details section
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I change user stash quota to 10 GB
    Then User stash quota changed successfully
    And User backup details table should be:
      | Computer | Encryption | Storage Used             | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 10 GB (change) | N/A         |             | delete  |
    When I navigate to Assign Keys section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 0 bytes / 10 GB      |
    And Partner total resources details table should be:
      |         | Active    | Assigned | Unassigned |
      | Desktop | 10 GB     | 0 bytes  | 240 GB     |
      | Server  | 0 bytes   | 0 bytes  | 0 bytes    |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 1               |
      | Stash Storage Usage: | 0 bytes / 10 GB |
    And I delete partner account

  @TC.19108 @BSA.1000
  Scenario: 19108 MozyEnterprise Partner Delete Stash container using the Delete link
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 12     | 10    | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyEnterprise partner:
      | name           | enable stash | stash quota |
      | TC.19108 user  | yes          | 5           |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I delete stash container for the user
    Then Popup window message should be Do you want to delete the user's stash? Note: Deleting a user's Stash removes all of the user's Stash files from the Web.
    And I click Cancel button on popup window
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I delete stash container for the user
    Then I click Continue button on popup window
    And User backup details table should not have stash record
    When I refresh Search List User section
    Then User search results should be:
      | User            | Name           | User Group           | Stash    | Machines | Storage | Storage Used |
      | @new_user_email | TC.19108 user  | (default user group) | Disabled | 0        | 0 bytes | none         |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 0                 |
      | Stash Storage Usage: | 0 bytes / 0 bytes |
    And I delete partner account

  @TC.19109 @BSA.1000
  Scenario: 19109 MozyEnterprise Partner Add Stash Container - Custom User Group with Email
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 12     | 10    | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    When I add a new user group:
      | name           | stash quota |
      | TC.19109 group | 5           |
    Then New user group should be created
    When I transfer resources from (default user group) to TC.19109 group with:
      | desktop licenses | desktop quota GB |
      | 2                | 20               |
    Then Resources should be transferred
    When I add a new user to a MozyEnterprise partner:
      | name           | user group     | enable stash | send stash invite |
      | TC.19109 user  | TC.19109 group | yes          | yes               |
    Then New user should be created
    When I search emails by keywords:
      | to              | subject      |
      | @new_user_email | enable stash |
    Then I should see 1 email(s)
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User            | Name           | User Group     | Stash   | Machines | Storage | Storage Used |
      | @new_user_email | TC.19109 user  | TC.19109 group | Enabled | 0        | 5 GB    | none         |
    When I view user details by newly created user email
    Then User details should be:
      | Name:                  | Enable Stash:               |
      | TC.19109 user (change) | Yes (Send Invitation Email) |
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I navigate to Search / List Machines section from bus admin console page
    Then Machine search results should be:
      | Machine | User            | User Group     | Data Center | Storage Used            |
      | Stash   | @new_user_email | TC.19109 group | qa6         | 0 bytes / 5 GB (change) |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota           | Desktop Keys | Desktop Quota            |
      | (default user group) * | 0     | 1      | 0           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 0 / 8        | 0.0 (0.0 active) / 230.0 |
      | TC.19109 group         | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 0 / 2        | 0.0 (5.0 active) / 20.0  |
    When I view TC.19109 group user group details
    Then User group users list details should be:
      | Name          | Stash   | Machines | Storage | Storage Used |
      | TC.19109 user | Enabled | 0        | 5 GB    | none         |
    When I navigate to Assign Keys section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 0 bytes / 5 GB       |
    And Partner user groups table should be:
      | Name                  | Active Storage | Allocated Storage |
      | (default user group)  | 0 GB           | 230 GB            |
      | TC.19109 group        | 5 GB           | 20 GB             |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 1              |
      | Stash Storage Usage: | 0 bytes / 5 GB |
    And I delete partner account

  @TC.19111 @BSA.1000
  Scenario: 19111 MozyEnterprise Partner Edit Stash Container - Custom User Group No Email
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 12     | 10    | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    When I add a new user group:
      | name           | stash quota |
      | TC.19111 group | 5           |
    Then New user group should be created
    When I transfer resources from (default user group) to TC.19111 group with:
      | desktop licenses | desktop quota GB |
      | 2                | 20               |
    Then Resources should be transferred
    When I add a new user to a MozyEnterprise partner:
      | name           | user group     | enable stash |
      | TC.19111 user  | TC.19111 group | yes          |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I cancel change user stash quota
    Then User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I click change stash quota text box
    Then Change stash quota hover message should be Max: 20 GB
    When I refresh User Details section
    And I change user stash quota to 999999999 GB
    Then Popup window message should be There is not enough storage available to add the default storage amount.
    And I close popup window
    When I refresh User Details section
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I change user stash quota to 10 GB
    Then User stash quota changed successfully
    And User backup details table should be:
      | Computer | Encryption | Storage Used             | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 10 GB (change) | N/A         |             | delete  |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota           | Desktop Keys | Desktop Quota            |
      | (default user group) * | 0     | 1      | 0           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 0 / 8        | 0.0 (0.0 active) / 230.0 |
      | TC.19111 group         | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 0 / 2        | 0.0 (10.0 active) / 20.0 |
    When I view TC.19111 group user group details
    Then User group users list details should be:
      | Name          | Stash   | Machines | Storage | Storage Used |
      | TC.19111 user | Enabled | 0        | 10 GB   | none         |
    When I navigate to Assign Keys section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 0 bytes / 10 GB      |
    And Partner total resources details table should be:
      |         | Active    | Assigned | Unassigned |
      | Desktop | 10 GB     | 0 bytes  | 240 GB     |
      | Server  | 0 bytes   | 0 bytes  | 0 bytes    |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 1               |
      | Stash Storage Usage: | 0 bytes / 10 GB |
    And I delete partner account

  @TC.19113 @BSA.1000
  Scenario: 19113 MozyEnterprise Partner Delete Stash container using the Delete link - Custom User Group with Email
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    When I add a new user group:
      | name           | stash quota |
      | TC.19113 group | 5           |
    Then New user group should be created
    When I transfer resources from (default user group) to TC.19113 group with:
      | desktop licenses | desktop quota GB |
      | 2                | 20               |
    Then Resources should be transferred
    And I add a new user to a MozyEnterprise partner:
      | name           | user group     | enable stash |
      | TC.19113 user  | TC.19113 group | yes          |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I delete stash container for the user
    Then Popup window message should be Do you want to delete the user's stash? Note: Deleting a user's Stash removes all of the user's Stash files from the Web.
    And I click Cancel button on popup window
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I delete stash container for the user
    Then I click Continue button on popup window
    And User backup details table should not have stash record
    When I refresh Search List User section
    Then User search results should be:
      | User            | Name           | User Group     | Stash    | Machines | Storage | Storage Used |
      | @new_user_eamil | TC.19113 user  | TC.19113 group | Disabled | 0        | 0 bytes | none         |
    When I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Stash Users | Server Keys | Server Quota           | Desktop Keys | Desktop Quota            |
      | (default user group) * | 0     | 1      | 0           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 0 / 8        | 0.0 (0.0 active) / 230.0 |
      | TC.19113 group         | 1     | 1      | 0           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 0 / 2        | 0.0 (0.0 active) / 20.0  |
    When I view TC.19113 group user group details
    Then User group users list details should be:
      | Name          | Stash    | Machines | Storage | Storage Used |
      | TC.19113 user | Disabled | 0        | 0 bytes | none         |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 2         |
    And Partner stash info should be:
      | Stash Users:         | 0                 |
      | Stash Storage Usage: | 0 bytes / 0 bytes |
    And I delete partner account

  @TC.19165 @BSA.3010
  Scenario: 19165 US Pro admin can see stash details in manage resources
    When I act as partner by:
      | email                 |
      | test_bsa3040@auto.com |
    When I navigate to Manage Resources section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 5 MB / 2 GB          |
