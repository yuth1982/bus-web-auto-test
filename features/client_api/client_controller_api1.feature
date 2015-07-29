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
    And I upload data to device
      | machine_id                     | GB  | user_name               |
      | <%=@clients.first.machine_id%> | 30  | <%=@users.first.email%> |
    And I get the machine info should be
      | quota      | user_spaceused |
      | 104857600  | 0              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name
