#Success Criteria:

#Machine detail view - I can set an optional max setting.
#I can remove the max setting for the machine
#The max setting can not be bigger than the one on user/user group/account.
#If the max is hit, then the machine will stop backing up. (refer to #94464)

Feature: Set/Remove Max at Machine

  As an Mozy administrator
  I want the ability to set a cap on a machine
  So that I can manage the machine

  Background:
    Given I log in bus admin console as administrator

  @TC.21071
  Scenario: 21071 [Itemized]Desktop machine and Stash can Set/Edit/Remove max
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name             |
      | 12     | 8     | 100 GB      | yes       | Set Max for Machine      |
    Then New partner should be created
    And I enable stash for the partner with 10 GB stash storage
    When I get the partner_id
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices | enable_stash |
      | Test | Shared               | 5               | Shared              | 10             | yes          |
    And I add new user(s):
      | name          | user_group | storage_type | storage_limit | devices | enable_stash |
      | TC.21071.User | Test       | Desktop      | 50            | 3       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | Machine1     | Desktop      | @partner_name |
    And I refresh User Details section
    Then device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update  | Action |
      | Machine1        | Desktop      | 0 / 50 GB      | Set                  | N/A          |        |
    And stash device table in user details should be:
      | Stash Container | Storage Type | Used/Available | Device Storage Limit | Last Update  | Action |
      | Stash           | Desktop      | 0 / 50 GB      | Set                  | N/A          |        |
    When I set machine max for Machine1
    And I input the machine max value for Machine1 to 10 GB
    And I cancel machine max for Machine1
    Then device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update  | Action |
      | Machine1        | Desktop      | 0 / 50 GB      | Set                  | N/A          |        |
    When I set machine max for Machine1
    Then The range of machine max for Machine1 by tooltips should be:
      | Min | Max |
      | 0   | 50  |
    When I input the machine max value for Machine1 to 10 GB
    And I save machine max for Machine1
    Then set max message should be:
      """
      Machine storage limit was set to 10 GB successfully
      """
    And device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update  | Action |
      | Machine1        | Desktop      | 0 / 10 GB      | 10 GB Edit Remove    | N/A          |        |
    When I edit machine max for Machine1
    And I input the machine max value for Machine1 to 20 GB
    And I cancel machine max for Machine1
    Then device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update  | Action |
      | Machine1        | Desktop      | 0 / 10 GB      | 10 GB Edit Remove    | N/A          |        |
    When I edit machine max for Machine1
    And I input the machine max value for Machine1 to 20 GB
    And I save machine max for Machine1
    Then set max message should be:
      """
      Machine storage limit was set to 20 GB successfully
      """
    And device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update  | Action |
      | Machine1        | Desktop      | 0 / 20 GB      | 20 GB Edit Remove    | N/A          |        |
    When I remove machine max for Machine1
    Then set max message should be:
      """
      Machine will share this user's storage
      """
    And device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update  | Action |
      | Machine1        | Desktop      | 0 / 50 GB      | Set                  | N/A          |        |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21074
  Scenario: 21074 [Itemized]Desktop machine and stash stop backing up when max is hit
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 8     | 100 GB      | yes       |
    Then New partner should be created
    And I enable stash for the partner with 10 GB stash storage
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices | enable_stash |
      | Test | Shared               | 5               | Shared              | 10             | yes          |
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices | enable_stash |
      | User1 | Test       | Desktop      | 50            | 3       | no           |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | User1      |
    Then I view user details by User1
    And I update the user password to default password
    And I add stash for the user with:
      | stash quota | send email |
      | 5           | no         |
    And I set user stash quota to 5 GB
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine1     | Desktop      |
    And I refresh User Details section
    When I set machine max for Machine1
    And I input the machine max value for Machine1 to 10 GB
    And I save machine max for Machine1
    Then set max message should be:
      """
      Machine storage limit was set to 10 GB successfully
      """
    And The range of machine max for Machine1 by tooltips should be:
      | Min | Max |
      | 0   | 50  |
    When I update Machine1 used quota to 10 GB
    And I update Stash used quota to 5 GB
    And The range of machine max for Stash by tooltips should be:
      | Min | Max |
      | 15  | 50  |
    Then Available quota of Machine1 should be 0 GB
    And Available quota of Stash should be 0 GB
    When I refresh User Details section
    Then I change user stash quota to 6 GB
    Then Available quota of Stash should be 1 GB
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21075
  Scenario: 21075 [Bundled]Server machine can Set/Edit/Remove max
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 200            | yes         |
    Then New partner should be created
    And I enable stash for the partner with 10 GB stash storage
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name | storage_type | server_support | enable_stash |
      | Test | Shared       | yes            | yes          |
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices | enable_stash |
      | User1 | Test       | Desktop      | 50            | 3       | no           |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | machine_name | machine_type | used_quota |
      | Machine1     | Desktop      | 0 GB       |
    When I refresh User Details section
    Then I set machine max for Machine1
    And I input the machine max value for Machine1 to 20 GB
    And I save machine max for Machine1
    Then device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update    | Action |
      | Machine1        | Desktop      | 0 / 20 GB      | 20 GB Edit Remove    | < a minute ago |        |
    Then I set machine max for Machine1
    And I input the machine max value for Machine1 to 30 GB
    And I save machine max for Machine1
    Then device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update    | Action |
      | Machine1        | Desktop      | 0 / 30 GB      | 30 GB Edit Remove    | < a minute ago |        |
    When I remove machine max for Machine1
    Then device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update    | Action |
      | Machine1        | Desktop      | 0 / 50 GB      | Set                  | < a minute ago |        |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21078
  Scenario: 21078 [Bundled]Desktop machine and stash stop backing up when max is hit
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 200            | yes         |
    Then New partner should be created
    And I enable stash for the partner with 10 GB stash storage
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name | storage_type | server_support | enable_stash |
      | Test | Shared       | yes            | yes          |
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices | enable_stash |
      | User1 | Test       | Desktop      | 50            | 3       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | machine_name | machine_type | used_quota |
      | Machine1     | Desktop      | 0 GB       |
    When I refresh User Details section
    And I set user stash quota to 5 GB
    When I set machine max for Machine1
    And I input the machine max value for Machine1 to 10 GB
    And I save machine max for Machine1
    Then set max message should be:
      """
      Machine storage limit was set to 10 GB successfully
      """
    And The range of machine max for Machine1 by tooltips should be:
      | Min | Max |
      | 0   | 50  |
    And The range of machine max for Stash by tooltips should be:
      | Min | Max |
      | 0   | 50  |
    When I update Machine1 used quota to 10 GB
    Then The range of machine max for Machine1 by tooltips should be:
      | Min | Max |
      | 10  | 50  |
    And I update Stash used quota to 5 GB
    Then The range of machine max for Stash by tooltips should be:
      | Min | Max |
      | 15  | 50  |
    Then Available quota of Machine1 should be 0 GB
    And Available quota of Stash should be 0 GB
    And I stop masquerading
    And I search and delete partner account by newly created partner company name