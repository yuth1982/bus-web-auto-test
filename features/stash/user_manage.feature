Feature: User stash setting management

  As a Mozy customer admin
  I want to add Sync to a new user with a stash storage
  so that users can start using Sync immediately

  Background:
    Given I log in bus admin console as administrator

  @TC.18972 @BSA.2040 @bus @stash
  Scenario: 18972 Add Sync link is not available in user view when stash is not enabled for the user
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.18972-1 | Desktop      | 10            | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    Then I should not see Enable Sync setting on user details section

  @TC.18973 @BSA.2040 @bus @stash
  Scenario: 18973 Add Sync link is available in user view when stash is enabled for the user
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
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.18973 user | (default user group) | Desktop      | 10            | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:  |
      | TC.18973 user (change) | No (Add Sync) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18974 @BSA.2040 @bus @stash
  Scenario: 18974 Click Add Sync link in user details section to enable stash
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 50 GB     |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name          | storage_type | storage_limit | devices |
      | TC.18974 user | Desktop      | 10            | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I enable stash without send email in user details section
    Then user details should be:
      | Name:                  | Enable Sync:               |
      | TC.18974 user (change) | Yes (Send Invitation Email) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19017 @BSA.2040 @bus @stash
  Scenario: 19017 User click Cancel will not enable stash
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 50 GB     |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name          | storage_type | storage_limit | devices |
      | TC.19017 user | Desktop      | 10            | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I cancel add user stash
    Then user details should be:
      | Name:                  | Enable Sync:  |
      | TC.19017 user (change) | No (Add Sync) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18978 @BSA.2050 @bus @stash
  Scenario: 18978 Sync options are not available in Add New User view when Sync is disabled
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    Then I should not see stash options
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18979 @BSA.2050 @bus @stash
  Scenario: 18979 Sync options are available in Add New User view when Sync is enabled
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    Then I should see stash options
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18981 @BSA.2050 @bus @stash
  Scenario: 18981 Add a new user with stash enabled
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
      | name          | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.18981 user | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:               |
      | TC.18981 user (change) | Yes (Send Invitation Email) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19019 @BSA.2050 @bus @stash
  Scenario: 19019 Add new user with stash not enabled
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name          | storage_type | storage_limit | enable_stash |
      | TC.19019 user | Desktop      | 10            | no           |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:  |
      | TC.19019 user (change) | No (Add Sync) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18990 @BSA.2070 @bus @stash
  Scenario: 18990 Send stash invitation email in user details section
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 50 GB     |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name          | storage_type | storage_limit | devices | enable_stash |
      | TC.18990 user | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I send stash invitation email
    When I search emails by keywords:
      | to              | subject      |
      | @new_user_email | enable stash |
    Then I should see 1 email(s)
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19121 @BSA.2070 @bus @stash
  Scenario: 19121 Click Add Sync link with default quota and send email
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
      | name          | user_group           | storage_type | devices |
      | TC.19121-user | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I enable stash with send email in user details section
    Then user details should be:
      | Name:                  | Enable Sync:               |
      | TC.19121-user (change) | Yes (Send Invitation Email) |
    When I search emails by keywords:
      | to              | subject      |
      | @new_user_email | enable stash |
    Then I should see 1 email(s)
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19122 @BSA.2070 @bus @stash
  Scenario: 19122 Add new user with stash enabled and send stash invite email
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
      | name          | user_group           | storage_type | devices | enable_stash |
      | TC.19121-user | (default user group) | Desktop      | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      | Action |
      | Sync           | 0 / 250 GB         | Set                  | N/A              |        |
# no send email option when adding a new user with stash
#    When I search emails by keywords:
#      | to              | subject      |
#      | @new_user_email | enable stash |
#    Then I should see 1 email(s)
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18995 @BSA.3030 @bus @2.5 @user_stories @stash
  Scenario: 18995 [Search/List Users View][P]"Sync" column shows and has valid value
    When I act as partner by:
      | email                        |
      | test3010_3030_3040@auto.com  |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User
    Then User search results should be:
      | User                   | Name           | User Group           | Sync    |
      | backup19045@test.com   | backup19045    | (default user group) | Disabled |
      | backup@test.com        | backup         | backup               | Disabled |
      | stash19045@test.com    | stash19045     | (default user group) | Enabled  |
      | stash@test.com         | stash          | stash                | Enabled  |

  @TC.18996 @BSA.3030 @bus @2.5 @user_stories @stash
  Scenario: 18996 [Search/List Users View][P]"Storage" and "Storage Used" column includes backup and stash
    When I act as partner by:
      | email                       |
      | test3010_3030_3040@auto.com |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User
    Then User search results should be:
      | User                   | Name           | User Group           | Sync    | Machines | Storage | Storage Used |
      | backup19045@test.com   | backup19045    | (default user group) | Disabled | 1        | 1 GB    | 10 MB        |
      | backup@test.com        | backup         | backup               | Disabled | 1        | 1 GB    | 10 MB        |
      | stash19045@test.com    | stash19045     | (default user group) | Enabled  | 0        | 2 GB    | 20 MB        |
      | stash@test.com         | stash          | stash                | Enabled  | 0        | 2 GB    | 20 MB        |

  @TC.19114 @TC.19115 @BSA.3040 @bus @2.5 @user_stories @US @enterprise @partner
  Scenario: 19114 19115 Enterprise Partner View User storage usage
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 4     |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name                 | user_group           | storage_type | devices |
      | TC.19115.backup-user | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | machine_name | machine_type | used_quota |
      | Machine1     | Desktop      | 10 GB      |
    And I refresh User Details section
    Then device table in user details should be:
      | Device   | Used/Available | Device Storage Limit | Last Update    | Action |
      | Machine1 | 10 GB / 90 GB  | Set                  | < a minute ago |        |
    And I close User Details section
    When I add new user(s):
      | name                | user_group           | storage_type | devices | enable_stash |
      | TC.19115.stash-user | (default user group) | Desktop      | 1       | yes          |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update Sync used quota to 20 GB
    And I refresh User Details section
    Then user details should be:
      | Name:                        | Enable Sync:               |
      | TC.19115.stash-user (change) | Yes (Send Invitation Email) |
    And stash device table in user details should be:
      | Sync Container | Used/Available | Device Storage Limit | Last Update    | Action |
      | Sync           | 20 GB / 70 GB  | Set                  | < a minute ago |        |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords   |
      | TC.19115   |
    Then User search results should be:
      | User                 | Name                 | Sync    | Machines | Storage         | Storage Used   | Created | Backed Up      |
      | <%=@users[1].email%> | TC.19115.stash-user  | Enabled  | 0        | Desktop: Shared | Desktop: 20 GB | today   | < a minute ago |
      | <%=@users[0].email%> | TC.19115.backup-user | Disabled | 1        | Desktop: Shared | Desktop: 10 GB | today   | 1 minute ago   |

  @TC.19116 @TC.19117  @BSA.3040 @bus @2.5 @user_stories @US @mozypro @partner
  Scenario: 19116 19117 Mozypro Partner View Sync status
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name                 | storage_type | devices | 
      | TC.19116.backup-user | Desktop      | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | machine_name | machine_type | used_quota |
      | Machine1     | Desktop      | 10 GB      |
    And I refresh User Details section
    Then device table in user details should be:
      | Device   | Used/Available | Device Storage Limit | Last Update    | Action |
      | Machine1 | 10 GB / 95 GB  | Set                  | < a minute ago |        |
    And I close User Details section
    When I add new user(s):
      | name                | storage_type | devices | enable_stash |
      | TC.19116.stash-user | Desktop      | 1       | yes          |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update Sync used quota to 20 GB
    And I refresh User Details section
    Then user details should be:
      | Name:                        | Enable Sync:               |
      | TC.19116.stash-user (change) | Yes (Send Invitation Email) |
    And stash device table in user details should be:
      | Sync Container | Used/Available | Device Storage Limit | Last Update    | Action |
      | Sync           | 20 GB / 75 GB  | Set                  | < a minute ago |        |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords   |
      | TC.19116   |
    Then User search results should be:
      | User                 | Name                 | Sync    | Machines | Storage | Storage Used | Created |
      | <%=@users[1].email%> | TC.19116.stash-user  | Enabled  | 0        | Shared  | 20 GB        | today   |
      | <%=@users[0].email%> | TC.19116.backup-user | Disabled | 1        | Shared  | 10 GB        | today   |
