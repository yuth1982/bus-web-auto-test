Feature: 97636 Client Controller API

  Background:
    Given I log in bus admin console as administrator

  @TC.20948 @bus @client_api
  Scenario: 20948 machine_get_info when 0<m.used_quota<u.total_quota
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20948.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name               | machine_type |
      | Machine1_20948 | <%=@users.first.email%> | Desktop      |
    And I get the machine id for client 0 by license key <%=@clients.first.license_key%>
    And I upload data to device by batch
      | machine_id                     | GB |
      | <%=@clients.first.machine_id%> | 30 |
    Then tds returns successful upload
    And I get the machine info should be
      | quota      | user_spaceused |
      | 104857600  | 0              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.21005 @bus @client_api
  Scenario: 21005 machine_get_info when 0<m.used_quota<u.total_quota by machine_id and other user's authentication
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Platinum      | 100            |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.21005.User1 | (default user group) | Desktop      | 10            | 2       |
      | TC.21005.User2 | (default user group) | Desktop      | 10            | 2       |
    Then 2 new user should be created
    And I search user by:
      | keywords            |
      | <%=@users[0].name%> |
    And I view user details by <%=@users[0].email%>
    And I update the user password to default password
    Then I close user details section
    And I search user by:
      | keywords            |
      | <%=@users[1].name%> |
    And I view user details by <%=@users[1].email%>
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name               | machine_type |
      | Machine1_21005 | <%=@users.first.email%> | Desktop      |
    And I get the machine id for client 0 by license key <%=@clients[0].license_key%>
    And I upload data to device by batch
      | machine_id                     | GB |
      | <%=@clients.first.machine_id%> | 30 |
    Then tds returns successful upload
    And I get the machine info with other user authentication should be
      """
        ERROR: PRO USER MACHINE CREATION INVALID
      """
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.21212 @bus @client_api
  Scenario: 21212 [Itemized]GET /client/user/resources API for desktop user with stash and machines
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.21212.User | (default user group) | Desktop      | 50            | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And Get client user resources api result should be
      | stash | backup | server | desktop |
      | 0     | 0      | 0      | 3       |
    And I use keyless activation to activate devices
      | user_email  | machine_name   | machine_type |
      | @user_email | Machine1_21212 | Desktop      |
    And I use keyless activation to activate devices
      | user_email  | machine_name   | machine_type |
      | @user_email | Machine2_21212 | Desktop      |
    And Get client user resources api result should be
      | stash | backup | server | desktop |
      | 0     | 2      | 0      | 3       |
    And I enable stash without send email in user details section
    And Get client user resources api result should be
      | stash | backup | server | desktop |
      | 1     | 2      | 0      | 3       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name



  @TC.21217 @bus @client_api
  Scenario: 21217 [Bunlded]GET /client/user/resources API with invalid authorization
    When I add a new MozyPro partner:
      | period | base plan | country        | net terms |
      | 12     | 500 GB    | United Kingdom | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name          | storage_type | storage_limit | devices | enable_stash |
      | TC.21217.User | Desktop      | 50            | 1       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name   | machine_type |
      | @user_email | Machine1_21217 | Desktop      |
    And Get client user resources api with invalid authorization result should like
    """
       ERROR: invalid token
    """
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name


