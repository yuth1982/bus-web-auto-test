Feature:
  Provision a Sync container for each user when the admin gives Sync to the user via:
  allocating/assigning Sync storage to the user, or through a bulk add for the user group.

  Background:
    Given I log in bus admin console as administrator

  @TC.19040 @BSA.1000 @bus @stash @general_requirements
  Scenario: 19040 MozyPro Partner Provision Sync Container - Default User Group no email invite
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
      | User                        | Name          | Sync    | Machines | Storage        | Storage Used |
      | <%=@new_users.first.email%> | TC.19040 User | Enabled | 0        | 10 GB (Limited)| None         |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:                |
      | TC.19040 User (change) | Yes (Send Invitation Email) |
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      |
      | Sync           | 0 / 10 GB          | Set                  | N/A              |
    When I navigate to Search / List Machines section from bus admin console page
    Then Machine search results should be:
      | Machine | User                        | User Group           | Data Center | Storage Used |
      | Sync    | <%=@new_users.first.email%> | (default user group) | qa6         | 0            |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And Partner stash info should be:
      | Users:              | 1 |
      | Storage Usage:      | 0 |
    And I delete partner account

  @TC.19078 @BSA.1000 @bus @stash
  Scenario: 19078 MozyPro Partner Add Sync to existing partner
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
      | User                        | Name          | Sync     | Machines | Storage        | Storage Used |
      | <%=@new_users.first.email%> | TC.19078 User | Disabled | 0        | 10 GB (Limited)| None         |
    And I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:  |
      | TC.19078 User (change) | No (Add Sync) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19080 @BSA.1000 @bus @stash
  Scenario: 19080 MozyPro Partner Add Sync Container Default User Group No Email
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
      | Name:                  | Enable Sync:               |
      | TC.19080 User (change) | Yes (Send Invitation Email) |
    When I search emails by keywords:
      | to                          | subject      |
      | <%=@new_users.first.email%> | enable stash |
    Then I should see 0 email(s)
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      |
      | Sync | 0 / 10 GB          | Set                  | N/A              |
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                        | Name          | Sync | Machines | Storage        | Storage Used |
      | <%=@new_users.first.email%> | TC.19080 User | Enabled | 0        | 10 GB (Limited)| None         |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner stash info should be:
      | Users:         | 1 |
      | Storage Usage: | 0 |
    And I delete partner account

  @TC.19022 @BSA.1000 @bus @stash
  Scenario: 19022 Reseller Partner Provision Sync Container - Custom User Group
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
      | User                        | Name          | User Group  | Sync | Machines | Storage        | Storage Used |
      | <%=@new_users.first.email%> | TC.19022 User | TC.19022 UG | Enabled | 0        | 10 GB (Limited)| None         |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:               |
      | TC.19022 User (change) | Yes (Send Invitation Email) |
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      |
      | Sync | 0 / 10 GB          | Set                  | N/A              |
    When I navigate to Search / List Machines section from bus admin console page
    Then Machine search results should be:
      | Machine | User                        | User Group  | Data Center | Storage Used |
      | Sync | <%=@new_users.first.email%> | TC.19022 UG | qa6         | 0            |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner stash info should be:
      | Users:         | 1 |
      | Storage Usage: | 0 |
    And I delete partner account

  @TC.18967 @BSA.1000 @bus @stash
  Scenario: 18967 Reseller Partner Add Sync to existing partner
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
      | User                     | Name           | User Group           | Sync | Machines | Storage        |
      | <%=@new_users[0].email%> | TC.18967 user1 | (default user group) | Enabled | 0        | 5 GB (Limited) |
      | <%=@new_users[1].email%> | TC.18967 user2 | (default user group) | Enabled | 0        | 5 GB (Limited) |
      | <%=@new_users[2].email%> | TC.18967 user3 | (default user group) | Enabled | 0        | 5 GB (Limited) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19063 @BSA.1000 @bus @stash
  Scenario: 19063 Reseller Partner Edit Sync Container - Custom User Group No Email
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
      The Sync Storage limit cannot be more than what is available for this user.
      """
    When I refresh User Details section
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      |
      | Sync | 0 / 10 GB          | Set                  | N/A              |
    And I set user stash quota to 5 GB
    When I refresh User Details section
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      |
      | Sync | 0 / 5 GB           | 5 GB Edit Remove     | N/A              |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And Partner stash info should be:
      | Users:         | 1 |
      | Storage Usage: | 0 |
    And I delete partner account

  @TC.19035 @BSA.1000 @bus @stash
  Scenario: 19035 MozyEnterprise Partner Provision Sync Container - Default User Group no email invite
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
      | User                        | Name          | Sync | Machines | Storage                 | Storage Used  |
      | <%=@new_users.first.email%> | TC.19035 User | Enabled | 0        | Desktop: 10 GB (Limited)| Desktop: None |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:               |
      | TC.19035 User (change) | Yes (Send Invitation Email) |
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      |
      | Sync | 0 / 10 GB          | Set                  | N/A              |
    When I navigate to Search / List Machines section from bus admin console page
    Then Machine search results should be:
      | Machine | User                        | User Group           | Data Center | Storage Used |
      | Sync | <%=@new_users.first.email%> | (default user group) | qa6         | 0            |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner stash info should be:
      | Users:         | 1 |
      | Storage Usage: | 0 |
    And I delete partner account

  @TC.19102 @BSA.1000 @bus @stash
  Scenario: 19102 MozyEnterprise Partner Add Sync to existing partner
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I act as newly created partner account
    When I navigate to Add New User section from bus admin console page
    Then I should not see stash options
    When I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.19102 user1 | (default user group) | Desktop      | 5             | 1       |
      | TC.19102 user2 |                      |              |               |         |
      | TC.19102 user3 |                      |              |               |         |
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
      | User                     | Name           | User Group           | Sync | Machines | Storage                 |
      | <%=@new_users[0].email%> | TC.19102 user1 | (default user group) | Enabled | 0        | Desktop: 5 GB (Limited) |
      | <%=@new_users[1].email%> | TC.19102 user2 | (default user group) | Enabled | 0        | Desktop: 5 GB (Limited)|
      | <%=@new_users[2].email%> | TC.19102 user3 | (default user group) | Enabled | 0        | Desktop: 5 GB (Limited)|
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19106 @BSA.1000 @bus @stash
  Scenario: 19106 MozyEnterprise Partner Edit Sync Container - Default User Group No Email
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
      The Sync Storage limit cannot be more than what is available for this user.
      """
    When I refresh User Details section
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      |
      | Sync | 0 / 10 GB          | Set                  | N/A              |
    And I set user stash quota to 5 GB
    When I refresh User Details section
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      |
      | Sync | 0 / 5 GB           | 5 GB Edit Remove     | N/A              |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And Partner stash info should be:
      | Users:         | 1 |
      | Storage Usage: | 0 |
    And I delete partner account

  @TC.19109 @BSA.1000 @bus @stash
  Scenario: 19109 MozyEnterprise Partner Add Sync Container - Custom User Group with Email
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
      | User                        | Name          | Sync | Machines | Storage                 | Storage Used  |
      | <%=@new_users.first.email%> | TC.19109 User | Enabled | 0        | Desktop: 10 GB (Limited)| Desktop: None |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:               |
      | TC.19109 User (change) | Yes (Send Invitation Email) |
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      |
      | Sync | 0 / 10 GB          | Set                  | N/A              |
    When I send stash invitation email
    When I search emails by keywords:
      | to                          | subject      |
      | <%=@new_users.first.email%> | enable stash |
    Then I should see 1 email(s)
    When I navigate to Search / List Machines section from bus admin console page
    Then Machine search results should be:
      | Machine | User                        | User Group  | Data Center | Storage Used |
      | Sync | <%=@new_users.first.email%> | TC.19109 UG | qa6         | 0            |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And Partner stash info should be:
      | Users:         | 1 |
      | Storage Usage: | 0 |
    And I delete partner account

  @TC.19111 @BSA.1000 @bus @stash
  Scenario: 19111 MozyEnterprise Partner Edit Sync Container - Custom User Group No Email
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I enable stash for the partner
    When I act as newly created partner account
    When I add a new Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | enable_stash | server_storage_type |
      | TC.19111 UG | Assigned             | 50                     | 1               | yes          | None                |
    Then TC.19111 UG user group should be created
    When I add new user(s):
      | name          | user_group  | storage_type | storage_limit | devices | enable_stash |
      | TC.19111 User | TC.19111 UG | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                        | Name          | Sync   | Machines | Storage                 | Storage Used  |
      | <%=@new_users.first.email%> | TC.19111 User | Enabled | 0        | Desktop: 10 GB (Limited)| Desktop: None |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:               |
      | TC.19111 User (change) | Yes (Send Invitation Email) |
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      |
      | Sync | 0 / 10 GB          | Set                  | N/A              |
    When I search emails by keywords:
      | to                          | subject      |
      | <%=@new_users.first.email%> | enable stash |
    Then I should see 0 email(s)
    When I navigate to Search / List Machines section from bus admin console page
    Then Machine search results should be:
      | Machine | User                        | User Group  | Data Center | Storage Used |
      | Sync | <%=@new_users.first.email%> | TC.19111 UG | qa6         | 0            |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And Partner stash info should be:
      | Users:         | 1 |
      | Storage Usage: | 0 |
    And I delete partner account


  @TC.19165 @BSA.3010 @bus @2.5 @user_stories @stash
  Scenario: 19165 US Pro admin can see stash details in manage resources
    When I act as partner by:
      | email                 |
      | test_bsa3040@auto.com |
    When I navigate to Manage Resources section from bus admin console page
    Then Partner resources general information should be:
      | Users: | Storage Usage: |
      | 1      | 5 MB / 2 GB    |
