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