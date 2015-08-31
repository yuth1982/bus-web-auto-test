Feature: Stabdard user Login

  Background:
    Given I log in bus admin console as administrator

  @TC.123733 @bus @user_login @tasks_p1
  Scenario: 123733:[Negative]Standard user can not log in bus & client with error or empty password
    When I add a new MozyPro partner:
      | period | base plan | security |
      | 12     | 100 GB    | Standard |
    And New partner should be created
    Then I get the partner_id
    Then I change root role to FedID role
    And I activate new partner admin with default password
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123733.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123733.User
    And I update the user password to reset password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123733 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB | password                                  |
      | <%=@new_clients.first.machine_id%> | 30 | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    Then tds returns successful upload
    Then I Log in as the user
    Then I navigate to new window
    And I access freyja from bus admin
    And I select options menu
    Then I click Change password in freyja
    And I change password from default password to reset password in freyja
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password       |
      | <%=@new_users[0].email%> | error password |
    Then Login page error message should be Incorrect email or password.
    Then I log in bus pid console with:
      | username                 | password |
      | <%=@new_users[0].email%> |          |
    Then Login page error message should be Incorrect email or password.
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123734 @bus @user_login @tasks_p1
  Scenario: 123734:Standard user log into BUS with upper or mixed case username
    When I add a new MozyPro partner:
      | period | base plan | security |
      | 12     | 100 GB    | Standard |
    And New partner should be created
    Then I get the partner_id
    Then I change root role to FedID role
    And I activate new partner admin with default password
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123734.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123734.User
    And I update the user password to reset password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with mixed username:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    Then the user log out bus
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with uppercase username:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    Then the user log out bus
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123735 @bus @user_login @tasks_p1
  Scenario: 123735:Standard user log into BUS with lower or mixed case username
    When I add a new MozyPro partner:
      | period | base plan | security |
      | 12     | 100 GB    | Standard |
    And New partner should be created
    Then I get the partner_id
    Then I change root role to FedID role
    And I activate new partner admin with default password
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123735.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123735.User
    And I update the user password to reset password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with mixed username:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    Then the user log out bus
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with lowercase username:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    Then the user log out bus
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123748  @bus @user_login @tasks_p1
  Scenario: 123748:MozyPro standard user login bus and freyja after activating and change password
    When I add a new MozyPro partner:
      | period | base plan  | security   | net terms |
      | 12     | 100 GB     | Standard   | yes       |
    And New partner should be created
    Then I change root role to FedID role
    Then I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123748.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123748.User
    And I click Send activation email again
    Then the user has activated the account with default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123748 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB | password                           |
      | <%=@new_clients.first.machine_id%> | 30 |<%=CONFIGS['global']['test_pwd'] %> |
    Then tds returns successful upload
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then I change password from default password to reset password in user login bus page
    Then Change password should be successfully
    And I access freyja from bus admin
    And I select options menu
    Then I click Change password in freyja
    And I change password from reset password to Hipaa password in freyja
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                      |
      | <%=@new_users[0].email%> | <%=QA_ENV['hipaa_password']%> |
    And I access freyja from bus admin
    And I select options menu
    And I logout freyja
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125619 @bus @user_login @tasks_p1
  Scenario: 125619:Partner changed to FedID partner user could not login
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  | security | net terms |
      | 12     | 18    | 100 GB      | FedID role | Standard | yes       |
    Then New partner should be created
    And I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.125619.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.125619.User
    Then I update the user password to default password
    Then I stop masquerading
    Then I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then Login page error message should be Incorrect email or password.
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.123749 @bus @user_login @tasks_p1
  Scenario: 123749:MozyEnterprise user login bus and freyja after changing password
    When I add a new MozyEnterprise partner:
      | period | users | server plan | security |
      | 12     | 10    | 250 GB      | Standard |
    And New partner should be created
    Then I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123749.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123749.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123749 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB | password                                  |
      | <%=@new_clients.first.machine_id%> | 30 | <%=CONFIGS['global']['test_pwd'] %> |
    Then tds returns successful upload
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    And I access freyja from bus admin
    And I select options menu
    Then I click Change password in freyja
    And I change password from default password to reset password in freyja
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    Then I log out user
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123753 @bus @user_login @tasks_p1
  Scenario: 123753:MozyPro standard user login bus or freyja after changing password in bus
    When I add a new MozyPro partner:
      | period | base plan | security |
      | 12     | 100 GB    | Standard |
    And New partner should be created
    Then I change root role to FedID role
    Then I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123753.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123753.User
    And I update the user password to Hipaa password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123753 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB | password                      |
      | <%=@new_clients.first.machine_id%> | 30 | <%=QA_ENV['hipaa_password']%> |
    Then tds returns successful upload
    Then I update the user password to reset password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    And I access freyja from bus admin
    And I select options menu
    And I logout freyja
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name
