Feature: Password change policy enforcement

  Background:
    Given I log in bus admin console as administrator

  @TC.132341 @bus @qa6
  Scenario: 132341: MozyPro partner admin change user password with "temporary password"
    When I use a existing partner:
      | company name            | admin email                           | partner type | partner id |
      | #141759 mozypro partner | mozyautotest+judy+lopez+1513@emc.com  | MozyPro      | 3491959    |
    And I log in bus admin console as new partner admintest1234
    And I add new user(s):
      | name            | storage_type | storage_limit | devices |
      | TC.132341.User  | Desktop      | 10            | 3       |
    Then 1 new user should be created
    And I wait for 30 seconds
    Then the user has activated the account with default password
    # MozyPro user log in BUS with pid
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then I will see the user account page

    When I log in bus admin console as new partner admintest1234
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.132341.User
    And I update the user temporary password to reset password
    And I wait for 30 seconds
    When I search emails by keywords:
      | subject          | to                  |
      | Password Changed | <%=@new_users[0].email%> |
    Then I should see 1 email(s)
    And I click login link from the email
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    And I reset password with default password
    And I will see reset password massage Your password has been changed.
    And I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then I will see the user account page

  @TC.132342 @bus @qa6
  Scenario: 132342: MozyPro partner (has subdomain) admin change user password with "temporary password"
    When I use a existing partner:
      | company name                      | admin email                               | partner type | partner id |
      | #141759 mozypro subdomain partner | mozyautotest+ralph+fernandez+1036@emc.com | MozyPro      | 3492087    |
    And I log in bus admin console as new partner admintest1234
    And I add new user(s):
      | name            | storage_type | storage_limit | devices |
      | TC.132342.User  | Desktop      | 10            | 3       |
    Then 1 new user should be created
    And I wait for 30 seconds
    Then the user has activated the account with default password
    # MozyPro user log in BUS with subdomain
    # add 141759mozyprosubdomain.mozypro.com in hosts
    Then I navigate to 141759mozyprosubdomain user login page
    Then I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then I will see the user account page

    When I log in bus admin console as new partner admintest1234
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.132342.User
    And I update the user temporary password to reset password
    And I wait for 30 seconds
    When I search emails by keywords:
      | subject          | to                  |
      | Password Changed | <%=@new_users[0].email%> |
    Then I should see 1 email(s)
    And I click login link from the email
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    And I reset password with default password
    And I will see reset password massage Your password has been changed.
    And I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then I will see the user account page

  @TC.132340 @bus @qa6
  Scenario: 132340: MozyEnterprise HIPAA partner admin change user password with "temporary password"
    When I use a existing partner:
      | company name                     | admin email                                   | partner type   | partner id |
      | #141759 Enterprise HIPAA partner | mozyautotest+qa6+141759enthipaaadmin@emc.com  | MozyEnterprise | 3493681    |
    And I log in bus admin console as new partner admin
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.132340.User | (default user group) | Server       | 10            | 2       |
    Then 1 new user should be created
    And I wait for 30 seconds
    Then the user has activated the account with default password
    # MozyPro user log in BUS with pid
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                           |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd']%> |
    Then I will see the user account page

    When I log in bus admin console as new partner admin
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.132340.User
    And I update the user temporary password to Hipaa password
    And I wait for 30 seconds
    When I search emails by keywords:
      | subject          | to                       |
      | Password Changed | <%=@new_users[0].email%> |
    Then I should see 1 email(s)
    And I click login link from the email
    Then I log in bus pid console with:
      | username                 | password                      |
      | <%=@new_users[0].email%> | <%=QA_ENV['hipaa_password']%> |
    And I reset password with reset password
    And I will see reset password massage Your password has been changed.
    And I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    Then I will see the user account page

  @TC.132338 @bus @qa6
  Scenario: 132338: OEM partner admin change user password with "temporary password"
    When I use a existing partner:
      | company name        | admin email                    | partner type | partner id |
      | #141759 oem partner | mozybus+5e9xugfavrw@gmail.com  | OEM          | 3491719    |
    And I log in bus admin console as new partner admintest1234
    And I add new itemized user(s):
      | name           | devices_server | quota_server | devices_desktop | quota_desktop |
      | TC.132338.User | 1              | 10           | 1               | 10            |
    And new itemized user should be created
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.132338.User
    And I update the user temporary password to reset password
    And I update the user temporary password to default password
    And I wait for 30 seconds
    When I search emails by keywords:
      | subject          | to                       |
      | Password Changed | <%=@new_users[0].email%> |
    Then I should see 1 email(s)
    # add oem.mozypro.com in hosts
    And I click login link from the email
    Then I log in bus admin console with user name @new_users[0].email and password default password
    And I reset password with reset password
    And I will see reset password massage Your password has been changed.
    And I click login link from the email
    And I log in bus admin console with user name @new_users[0].email and password reset password
    Then I will see the user account page

