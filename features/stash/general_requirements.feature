Feature:
  Provision a Stash container for each user when the admin gives Stash to the user via:
  allocating/assigning Stash storage to the user, or through a bulk add for the user group.

  Background:
    Given I log in bus admin console as administrator

  @TC.19040 @BSA.1000 @bus @stash @general_requirements
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
      | to                          | subject      |
      | <%=@new_users.first.email%> | enable stash |
    Then I should see 0 email(s)
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                        | Name          | Stash   | Machines | Storage        | Storage Used |
      | <%=@new_users.first.email%> | TC.19040 User | Enabled | 0        | 10 GB (Limited)| None         |
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

  @TC.19078 @BSA.1000 @bus @stash
  Scenario: 19078 MozyPro Partner Add Stash to existing partner
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    Then I should not see stash options
    When I add new user(s):
      | name          | storage_type | storage_limit | devices |
      | TC.19078 User | Desktop      | 10            | 1       |
    Then 1 new user should be created
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    When I enable stash for the partner
    And I act as newly created partner account
    And I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                        | Name          | Stash    | Machines | Storage        | Storage Used |
      | <%=@new_users.first.email%> | TC.19078 User | Disabled | 0        | 10 GB (Limited)| None         |
    And I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Stash:  |
      | TC.19078 User (change) | No (Add Stash) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19080 @BSA.1000 @bus @stash
  Scenario: 19080 MozyPro Partner Add Stash Container Default User Group No Email
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    Then New partner should be created
    When I enable stash for the partner
    And I act as newly created partner account
    And I add new user(s):
      | name          | storage_type | storage_limit | devices |
      | TC.19080 User | Desktop      | 10            | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I enable stash without send email in user details section
    Then user details should be:
      | Name:                  | Enable Stash:               |
      | TC.19080 User (change) | Yes (Send Invitation Email) |
    When I search emails by keywords:
      | to                          | subject      |
      | <%=@new_users.first.email%> | enable stash |
    Then I should see 0 email(s)
    And stash device table in user details should be:
      | Stash Container | Used/Available     | Device Storage Limit | Last Update      |
      | Stash           | 0 / 10 GB          | Set                  | N/A              |
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                        | Name          | Stash   | Machines | Storage        | Storage Used |
      | <%=@new_users.first.email%> | TC.19080 User | Enabled | 0        | 10 GB (Limited)| None         |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner stash info should be:
      | Stash Users:         | 1 |
      | Stash Storage Usage: | 0 |
    And I delete partner account

  @TC.19022 @BSA.1000 @bus @stash
  Scenario: 19022 Reseller Partner Provision Stash Container - Custom User Group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     | Silver        | 100            | yes       |
    Then New partner should be created
    When I enable stash for the partner
    And I act as newly created partner account
    And I add a new Bundled user group:
      | name        | storage_type | enable_stash |
      | TC.19022 UG | Shared       | yes          |
    Then TC.19022 UG user group should be created
    And I add new user(s):
      | name          | user_group  | storage_type | storage_limit | devices | enable_stash |
      | TC.19022 User | TC.19022 UG | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                        | Name          | User Group  | Stash   | Machines | Storage        | Storage Used |
      | <%=@new_users.first.email%> | TC.19022 User | TC.19022 UG | Enabled | 0        | 10 GB (Limited)| None         |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Stash: |
      | TC.19022 User (change) | Yes           |
    And stash device table in user details should be:
      | Stash Container | Used/Available     | Device Storage Limit | Last Update      |
      | Stash           | 0 / 10 GB          | Set                  | N/A              |
    When I navigate to Search / List Machines section from bus admin console page
    Then Machine search results should be:
      | Machine | User                        | User Group  | Data Center | Storage Used |
      | Stash   | <%=@new_users.first.email%> | TC.19022 UG | qa6         | 0            |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner stash info should be:
      | Stash Users:         | 1 |
      | Stash Storage Usage: | 0 |
    And I delete partner account

  @TC.18967 @BSA.1000 @bus @stash
  Scenario: 18967 Reseller Partner Add Stash to existing partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     | Silver        | 100            | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    Then I should not see stash options
    When I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.18967 user1 | (default user group) | Desktop      | 5             | 1       |
      | TC.18967 user2 |                      |              |               |         |
      | TC.18967 user3 |                      |              |               |         |
    Then 3 new user should be created
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    When I enable stash for the partner
    And I add stash to all users for the partner
    And I act as newly created partner account
    And I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | User                     | Name           | User Group           | Stash   | Machines | Storage        |
      | <%=@new_users[0].email%> | TC.18967 user1 | (default user group) | Enabled | 0        | 5 GB (Limited) |
      | <%=@new_users[1].email%> | TC.18967 user2 | (default user group) | Enabled | 0        | 5 GB (Limited) |
      | <%=@new_users[2].email%> | TC.18967 user3 | (default user group) | Enabled | 0        | 5 GB (Limited) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19063 @BSA.1000 @bus @stash
  Scenario: 19063 Reseller Partner Edit Stash Container - Custom User Group No Email
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     | Silver        | 100            | yes       |
    Then New partner should be created
    When I enable stash for the partner
    And I act as newly created partner account
    And I add a new Bundled user group:
      | name        | storage_type | enable_stash |
      | TC.19063 UG | Shared       | yes          |
    Then TC.19063 UG user group should be created
    And I add new user(s):
      | name          | user_group  | storage_type | storage_limit | devices | enable_stash |
      | TC.19063 User | TC.19063 UG | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I set user stash quota to 999999999 GB
    Then set max message should be:
      """
      Machine Storage limit cannot be set to 999999999 GB, out of resource.
      """
    When I refresh User Details section
    And stash device table in user details should be:
      | Stash Container | Used/Available     | Device Storage Limit | Last Update      |
      | Stash           | 0 / 10 GB          | Set                  | N/A              |
    And I set user stash quota to 5 GB
    When I refresh User Details section
    And stash device table in user details should be:
      | Stash Container | Used/Available     | Device Storage Limit | Last Update      |
      | Stash           | 0 / 5 GB           | 5 GB Edit Remove     | N/A              |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And Partner stash info should be:
      | Stash Users:         | 1 |
      | Stash Storage Usage: | 0 |
    And I delete partner account

  @TC.19035 @BSA.1000 @bus @stash
  Scenario: 19035 MozyEnterprise Partner Provision Stash Container - Default User Group no email invite
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I enable stash for the partner
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.19035 User | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I search emails by keywords:
      | to                          | subject      |
      | <%=@new_users.first.email%> | enable stash |
    Then I should see 0 email(s)
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                        | Name          | Stash   | Machines | Storage                 | Storage Used  |
      | <%=@new_users.first.email%> | TC.19035 User | Enabled | 0        | Desktop: 10 GB (Limited)| Desktop: None |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Stash:               |
      | TC.19035 User (change) | Yes (Send Invitation Email) |
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
    Then Partner stash info should be:
      | Stash Users:         | 1 |
      | Stash Storage Usage: | 0 |
    And I delete partner account

  @TC.19102 @BSA.1000 @bus @stash
  Scenario: 19102 MozyEnterprise Partner Add Stash to existing partner
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I act as newly created partner account
    When I navigate to Add New User section from bus admin console page
    Then I should not see stash options
    When I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices |
      | TC.19102 user1  | (default user group) | Desktop      | 5             | 1       |
      | TC.19102 user2  | (default user group) | Desktop      | 10            | 2       |
      | TC.19102 user3  | (default user group) | Desktop      | 15            | 3       |
    Then 3 new user should be created
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    When I enable stash for the partner
    And I add stash to all users for the partner
    And I act as newly created partner account
    And I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | User                     | Name           | User Group           | Stash   | Machines | Storage                 |
      | <%=@new_users[0].email%> | TC.19102 user1 | (default user group) | Enabled | 0        | Desktop: 5 GB (Limited) |
      | <%=@new_users[1].email%> | TC.19102 user2 | (default user group) | Enabled | 0        | Desktop: 10 GB (Limited)|
      | <%=@new_users[2].email%> | TC.19102 user3 | (default user group) | Enabled | 0        | Desktop: 15 GB (Limited)|
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19106 @BSA.1000 @bus @stash
  Scenario: 19106 MozyEnterprise Partner Edit Stash Container - Default User Group No Email
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 12     | 10    | yes       |
    Then New partner should be created
    When I enable stash for the partner
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.19106 User | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I set user stash quota to 999999999 GB
    Then set max message should be:
      """
      Machine Storage limit cannot be set to 999999999 GB, out of resource.
      """
    When I refresh User Details section
    And stash device table in user details should be:
      | Stash Container | Used/Available     | Device Storage Limit | Last Update      |
      | Stash           | 0 / 10 GB          | Set                  | N/A              |
    And I set user stash quota to 5 GB
    When I refresh User Details section
    And stash device table in user details should be:
      | Stash Container | Used/Available     | Device Storage Limit | Last Update      |
      | Stash           | 0 / 5 GB           | 5 GB Edit Remove     | N/A              |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And Partner stash info should be:
      | Stash Users:         | 1 |
      | Stash Storage Usage: | 0 |
    And I delete partner account

  @TC.19109 @BSA.1000 @bus @stash
  Scenario: 19109 MozyEnterprise Partner Add Stash Container - Custom User Group with Email
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I enable stash for the partner
    When I act as newly created partner account
    When I add a new Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | enable_stash | server_storage_type |
      | TC.19109 UG | Assigned             | 50                     | 1               | yes          | None                |
    Then TC.19109 UG user group should be created
    When I add new user(s):
      | name          | user_group  | storage_type | storage_limit | devices | enable_stash |
      | TC.19109 User | TC.19109 UG | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                        | Name          | Stash   | Machines | Storage                 | Storage Used  |
      | <%=@new_users.first.email%> | TC.19109 User | Enabled | 0        | Desktop: 10 GB (Limited)| Desktop: None |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Stash:               |
      | TC.19109 User (change) | Yes (Send Invitation Email) |
    And stash device table in user details should be:
      | Stash Container | Used/Available     | Device Storage Limit | Last Update      |
      | Stash           | 0 / 10 GB          | Set                  | N/A              |
    When I send stash invitation email
    When I search emails by keywords:
      | to                          | subject      |
      | <%=@new_users.first.email%> | enable stash |
    Then I should see 1 email(s)
    When I navigate to Search / List Machines section from bus admin console page
    Then Machine search results should be:
      | Machine | User                        | User Group  | Data Center | Storage Used |
      | Stash   | <%=@new_users.first.email%> | TC.19109 UG | qa6         | 0            |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And Partner stash info should be:
      | Stash Users:         | 1 |
      | Stash Storage Usage: | 0 |
    And I delete partner account

  @TC.19111 @BSA.1000 @bus @stash
  Scenario: 19111 MozyEnterprise Partner Edit Stash Container - Custom User Group No Email
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I enable stash for the partner
    When I act as newly created partner account
    When I add a new Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | enable_stash | server_storage_type |
      | TC.19109 UG | Assigned             | 50                     | 1               | yes          | None                |
    Then TC.19109 UG user group should be created
    When I add new user(s):
      | name          | user_group  | storage_type | storage_limit | devices | enable_stash |
      | TC.19109 User | TC.19109 UG | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                        | Name          | Stash   | Machines | Storage                 | Storage Used  |
      | <%=@new_users.first.email%> | TC.19109 User | Enabled | 0        | Desktop: 10 GB (Limited)| Desktop: None |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Stash:               |
      | TC.19109 User (change) | Yes (Send Invitation Email) |
    And stash device table in user details should be:
      | Stash Container | Used/Available     | Device Storage Limit | Last Update      |
      | Stash           | 0 / 10 GB          | Set                  | N/A              |
    When I search emails by keywords:
      | to                          | subject      |
      | <%=@new_users.first.email%> | enable stash |
    Then I should see 0 email(s)
    When I navigate to Search / List Machines section from bus admin console page
    Then Machine search results should be:
      | Machine | User                        | User Group  | Data Center | Storage Used |
      | Stash   | <%=@new_users.first.email%> | TC.19109 UG | qa6         | 0            |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And Partner stash info should be:
      | Stash Users:         | 1 |
      | Stash Storage Usage: | 0 |
    And I delete partner account

  @TC.19113 @BSA.1000 @bus @stash
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

  @TC.19165 @BSA.3010 @bus @2.5 @user_stories @stash
  Scenario: 19165 US Pro admin can see stash details in manage resources
    When I act as partner by:
      | email                 |
      | test_bsa3040@auto.com |
    When I navigate to Manage Resources section from bus admin console page
    Then Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 5 MB / 2 GB          |
