Feature: Users Storage/Device/Product Key Section

  Background:
    Given I log in bus admin console as administrator

  @TC.20993 @bus @tasks_p2
  Scenario: Mozy-20993:[Itemized]Add Edit and Remove max at user for Desktop Storage
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 100 GB      |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.20993_user | (default user group) | Desktop      | 90            | 1       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I check user storage limit is 90 GB
    And I edit user storage limit to 10 GB
    Then I check user storage limit is 10 GB
    When I remove user storage limit No
    Then I check user storage limit is 10 GB
    When I remove user storage limit Yes
    Then I check user storage limit set link
    And I check user storage limit help message should be:
    """
    The User storage limit must be great than the largest limit set for all machines of this user. <br />The User storage limit must be less than the limit set at the Group level.
    """
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20996 @bus @tasks_p2
  Scenario: Mozy-20996:[Bundled]Add Edit below/over quota values at user will show error
    When I add a new MozyPro partner:
      | period | root role               | base plan  | server plan | storage add on 50 gb |
      | 1      | Bundle Pro Partner Root | 100 GB     |  yes        | 2            |
    And New partner should be created
    And I act as newly created partner
    And I add a new Bundled user group:
      | name        | storage_type | server_support |
      | Shared_test | Shared       | yes            |
    Then Shared_test user group should be created
    When I add a new Bundled user group:
      | name                 | storage_type | limited_quota | server_support |
      | Shared_with_max_test | Limited      | 50            | yes            |
    Then Shared_with_max_test user group should be created
    When I add a new Bundled user group:
      | name          | storage_type | assigned_quota | server_support |
      | Assigned_test | Assigned     | 30             | yes            |
    Then Assigned_test user group should be created
    And I add new user(s):
      | name          | user_group  | storage_type | storage_limit  |
      | TC.20996_user | Shared_test | Server       | 201           |
    Then Add new user error message should be:
    """
    User Group Shared_test does not have enough storage available.
    """
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit  |
      | TC.20996_user | Shared_with_max_test | Server       | 51             |
    Then Add new user error message should be:
    """
    User Group Shared_with_max_test does not have enough storage available.
    """
    And I add new user(s):
      | name          | user_group    | storage_type | storage_limit  |
      | TC.20996_user | Assigned_test | Server       | 31             |
    Then Add new user error message should be:
    """
    User Group Assigned_test does not have enough storage available.
    """
    And I add new user(s):
      | name            | user_group  | storage_type | storage_limit  |devices |
      | TC.20996_user_1 | Shared_test | Server       | 90             |3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.20996_user_1
    And I edit user storage limit to 201 GB
    Then Edit user error message should be:
    """
    Use between 0 and 200 GB for limited storage.
    """
    Then I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name     | user_name                   | machine_type |
      | Machine1_20996_1  | <%=@new_users.first.email%> | Server      |
    Then I use keyless activation to activate devices
      | machine_name     | user_name                   | machine_type |
      | Machine1_20996_2  | <%=@new_users.first.email%> | Server      |
    And I refresh User Details section
    Then I set device Machine1_20996_1 storage limit to 40 GB
    Then I set device Machine1_20996_2 storage limit to 50 GB
    And I edit user storage limit to 49 GB
    Then Edit user error message should be:
    """
    Use between 50 and 200 GB for limited storage.
    """
    And I edit user storage limit to 51 GB
    Then I check user storage limit is 51 GB
    Then I close User Details section
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit  |
      | TC.20996_user_2 | Shared_with_max_test | Server       | 49             |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.20996_user_2
    And I edit user storage limit to 51 GB
    Then Edit user error message should be:
    """
    Use between 0 and 50 GB for limited storage.
    """
    Then I close User Details section
    And I add new user(s):
      | name            | user_group    | storage_type | storage_limit  |
      | TC.20996_user_3 | Assigned_test | Server       | 29             |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.20996_user_3
    And I edit user storage limit to 31 GB
    Then Edit user error message should be:
    """
    Use between 0 and 30 GB for limited storage.
    """
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20997 @bus @tasks_p2
  Scenario: Mozy-20997:[Bundled]Add Edit(save and cancel) and Remove max at user
     When I add a new MozyPro partner:
      | period | root role               | base plan  | server plan |
      | 1      | Bundle Pro Partner Root | 100 GB     |  yes        |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20997_user | (default user group) | Desktop      | 90            | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I update the user password to default password
    Then I check user storage limit is 90 GB
    And I cancel edit user storage limit to 10 GB
    Then I check user storage limit is 90 GB
    And I edit user storage limit to 10 GB
    Then I check user storage limit is 10 GB
    When I remove user storage limit No
    Then I check user storage limit is 10 GB
    When I remove user storage limit Yes
    Then I check user storage limit set link
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine1_20997 | <%=@new_users.first.email%> | Desktop      |
    And I get the machine info should be
      | quota        | user_spaceused |
      | 104857600    |    0           |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20999 @bus @tasks_p2
  Scenario: Mozy-20999:[Bundled]All machines stop backing up when a server user hits its max
    When I add a new MozyPro partner:
      | period | root role               | base plan  | server plan | storage add on 50 gb |
      | 1      | Bundle Pro Partner Root | 100 GB     |  yes        | 2                    |
    And New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name          | user_group           | storage_type | devices |
      | TC.20999_user | (default user group) | Server       | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I update the user password to default password
    Then I check user storage limit set link
    Then I set user storage limit to 10 GB
    Then I check user storage limit is 10 GB
    Then I use keyless activation to activate devices
      | machine_name     | user_name                | machine_type |
      | Machine1_20999_1 | <%=@new_users[0].email%> | Server       |
    Then I use keyless activation to activate devices
      | machine_name     | user_name                | machine_type |
      | Machine1_20999_2 | <%=@new_users[0].email%> | Server       |
    Then I refresh User Details section
    And I set device Machine1_20999_1 storage limit to 5 GB
    And I set device Machine1_20999_2 storage limit to 5 GB
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 5  |
    Then tds returns successful upload
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[1].machine_id%> | 5  |
    Then tds returns successful upload
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[1].machine_id%> | 1  |
    Then tds return message should be:
    """
    Account or container quota has been exceeded
    """
    Then the machine <%=@clients[0].machine_id%> available quota should be 0
    Then the machine <%=@clients[1].machine_id%> available quota should be 0
    And I edit user storage limit to 20 GB
    And I edit device Machine1_20999_1 storage limit to 10 GB
    Then the machine <%=@clients[0].machine_id%> available quota should be 5368709120
    Then the machine <%=@clients[1].machine_id%> available quota should be 0
    And I edit user storage limit to 10 GB
    Then the machine <%=@clients[0].machine_id%> available quota should be 0
    Then the machine <%=@clients[1].machine_id%> available quota should be 0
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.132303 @bus @tasks_p2
  Scenario: Mozy-132303:[Itemized]All machines stop backing up when a serveruser hits its max
    When I add a new MozyEnterprise partner:
      | period | users  | server plan |
      | 12     | 10     | 100 GB      |
    And New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | devices |
      | TC.132303_user | (default user group) | Server       | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I update the user password to default password
    Then I check user storage limit set link
    Then I set user storage limit to 10 GB
    Then I check user storage limit is 10 GB
    Then I use keyless activation to activate devices
      | machine_name     | user_name                    | machine_type |
      | Machine1_132303_1 | <%=@new_users.first.email%> | Server       |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 6  |
    Then tds returns successful upload
    Then I use keyless activation to activate devices
      | machine_name     | user_name                    | machine_type |
      | Machine1_132303_2 | <%=@new_users.first.email%> | Server       |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[1].machine_id%> | 4  |
    Then tds returns successful upload
    Then I refresh User Details section
    Then the machine <%=@clients[0].machine_id%> available quota should be 0
    Then the machine <%=@clients[1].machine_id%> available quota should be 0
    And I edit user storage limit to 20 GB
    Then the machine <%=@clients[0].machine_id%> available quota should be 10737418240
    Then the machine <%=@clients[1].machine_id%> available quota should be 10737418240
    And I edit user storage limit to 5 GB
    Then the machine <%=@clients[0].machine_id%> available quota should be 0
    Then the machine <%=@clients[1].machine_id%> available quota should be 0
    And I stop masquerading
    And I search and delete partner account by newly created partner company name


