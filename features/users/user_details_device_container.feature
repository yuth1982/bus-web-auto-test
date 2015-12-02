Feature: User Details Device Container

  Background:
    Given I log in bus admin console as administrator

  @TC.21022 @bus @tasks_p2
  Scenario: Mozy-21022:Bundled Pro - Show used and available storage - single device
    When I add a new MozyPro partner:
      | period | root role               | base plan  |
      | 1      | Bundle Pro Partner Root | 100 GB     |
    And New partner should be created
    And I act as newly created partner
    When I add a new Bundled user group:
      | name              | storage_type | assigned_quota |
      | TC.21022-Assigned | Assigned     | 50             |
    Then TC.21022-Assigned user group should be created
    And I add new user(s):
      | name          | user_group        | storage_type | devices |
      | TC.21022_user | TC.21022-Assigned | Desktop      | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name     | user_name                | machine_type |
      | Machine1_21022   | <%=@new_users[0].email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 5  |
    Then tds returns successful upload
    And I refresh User Details section
    Then device table in user details should be:
      | Device         | Used/Available | Device Storage Limit |
      | Machine1_21022 | 5 GB / 45 GB   | Set                  |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21025 @bus @tasks_p2
  Scenario: Mozy-21025:Bundled Pro - Device Storage Limit column - Multiple devices
    When I add a new MozyPro partner:
      | period | root role               | base plan  |
      | 1      | Bundle Pro Partner Root | 100 GB     |
    And New partner should be created
    And I act as newly created partner
    When I add a new Bundled user group:
      | name             | storage_type | limited_quota |
      | TC.21025-Limited | Limited      | 50            |
    Then TC.21025-Limited user group should be created
    And I add new user(s):
      | name          | user_group       | storage_type | devices |
      | TC.21025_user | TC.21025-Limited | Desktop      | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name     | user_name                | machine_type |
      | Machine1_21025   | <%=@new_users[0].email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 5  |
    Then tds returns successful upload
    Then I use keyless activation to activate devices
      | machine_name       | user_name                | machine_type |
      | Machine1_21025_1   | <%=@new_users[0].email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[1].machine_id%> | 5  |
    Then tds returns successful upload
    And I refresh User Details section
    Then device table in user details should be:
      | Device           | Used/Available | Device Storage Limit |
      | Machine1_21025   | 5 GB / 40 GB      | Set               |
      | Machine1_21025_1 | 5 GB / 40 GB      | Set               |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21027 @bus @tasks_p2
  Scenario: Mozy-21027:Bundled Pro - Show the correct availalbe storage at the approprate level - User group
    When I add a new MozyPro partner:
      | period | root role               | base plan  |
      | 1      | Bundle Pro Partner Root | 100 GB     |
    And New partner should be created
    And I act as newly created partner
    When I add a new Bundled user group:
      | name            | storage_type |
      | TC.21027-Shared | Shared       |
    Then TC.21027-Shared user group should be created
    And I add new user(s):
      | name          | user_group      | storage_type | devices |
      | TC.21027_user | TC.21027-Shared | Desktop      | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name     | user_name                | machine_type |
      | Machine1_21027   | <%=@new_users[0].email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 5  |
    Then tds returns successful upload
    Then I use keyless activation to activate devices
      | machine_name       | user_name                | machine_type |
      | Machine1_21027_1   | <%=@new_users[0].email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[1].machine_id%> | 5  |
    Then tds returns successful upload
    And I refresh User Details section
    Then device table in user details should be:
      | Device           | Used/Available | Device Storage Limit |
      | Machine1_21027   | 5 GB / 90 GB      | Set               |
      | Machine1_21027_1 | 5 GB / 90 GB      | Set               |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21036 @bus @tasks_p2
  Scenario:  Mozy-21036:Reseller Bundled - Device Storage Limit column - Multiple devices
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name          | user_group           | storage_type | devices |
      | TC.21036_user | (default user group) | Desktop      | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name       | user_name                | machine_type |
      | Machine1_21036_1   | <%=@new_users[0].email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 5  |
    Then tds returns successful upload
    Then I use keyless activation to activate devices
      | machine_name     | user_name                | machine_type |
      | Machine1_21036_2 | <%=@new_users[0].email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[1].machine_id%> | 5  |
    Then tds returns successful upload
    And I refresh User Details section
    Then device table in user details should be:
      | Device           | Used/Available | Device Storage Limit |
      | Machine1_21036_1 | 5 GB / 90 GB      | Set               |
      | Machine1_21036_2 | 5 GB / 90 GB      | Set               |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21043 @bus @tasks_p2
  Scenario:  Mozy-21043:Enterprise - Storage type column - with stash
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    And New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name          | user_group           | storage_type | devices | enable_stash |
      | TC.21043_user | (default user group) | Desktop      | 3       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name     | user_name                | machine_type |
      | Machine1_21043_1 | <%=@new_users[0].email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 5  |
    Then tds returns successful upload
    And I refresh User Details section
    Then device table in user details should be:
      | Device           | Storage Type | Used/Available | Device Storage Limit |
      | Machine1_21043_1 | Desktop      | 5 GB / 245 GB  | Set                  |
    And stash device table in user details should be:
      | Sync Container | Storage Type | Used/Available     | Device Storage Limit |
      | Sync           | Desktop      | 0 / 245 GB         | Set                  |
    Then I close the user detail page
    And I add new user(s):
      | name            | user_group           | storage_type | devices |
      | TC.21043_user_1 | (default user group) | Server       | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name     | user_name                | machine_type |
      | Machine1_21043_2 | <%=@new_users[0].email%> | Server       |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[1].machine_id%> | 5  |
    Then tds returns successful upload
    And I refresh User Details section
    Then device table in user details should be:
      | Device           | Storage Type | Used/Available | Device Storage Limit |
      | Machine1_21043_2 | Server       | 5 GB / 245 GB  | Set                  |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name
    