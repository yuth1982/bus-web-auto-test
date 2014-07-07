Feature: Login bus admin console

  @TC.2134 @bus @log_in_screen
  Scenario: 2134 Attempt to log into BUS with a invalid username
    When I navigate to bus admin console login page
    And I log in bus admin console with user name invalid_name@mozy.com and password Naich4yei8
    Then Login page error message should be Incorrect email or password.

  @TC.2135 @bus @log_in_screen
  Scenario: 2135 Attempt to log into BUS with a invalid password
    When I navigate to bus admin console login page
    And I log in bus admin console with user name qa1+automation+admin@mozy.com and password wrong_password
    Then Login page error message should be Incorrect email or password.

  @TC.2187 @bus @log_in_screen
  Scenario: 2187 Prevent Session Fixation
    When I navigate to bus admin console login page
    And I save login page cookies _session_id value
    And I log in bus admin console with user name qa1+automation+admin@mozy.com and password Naich4yei8
    And I save admin console page cookies _session_id value
    Then Two cookies value should be different
    When I search partner by:
      | name  |
      | mozy  |
    And Admin console page cookies _session_id value should not changed

  @TC.120658 @bus @log_in_screen
  Scenario: 120658 Standard admin log into BUS with upper/mixed case username
    When I navigate to bus admin console login page
    Then I log into bus admin console with uppercase Standard admin and Standard password
    And I log out bus admin console
    Then I navigate to bus admin console login page
    And I log into bus admin console with mixed case Standard admin and Standard password
    And I log out bus admin console

  @TC.120659 @bus @log_in_screen
  Scenario: 120659 Hipaa admin log into BUS with upper/mixed case username
    When I navigate to bus admin console login page
    Then I log into bus admin console with uppercase Hipaa admin and Hipaa password
    And I log out bus admin console
    Then I navigate to bus admin console login page
    And I log into bus admin console with mixed case Hipaa admin and Hipaa password
    And I log out bus admin console

  @TC.120660 @bus @log_in_screen
  Scenario: 120660 Standard user log into BUS with upper/mixed case username
    When I navigate to Standard subdomain user login page
    Then I log into Standard subdomain with uppercase username Standard user and Standard password
    And I log out user
    Then I log into Standard subdomain with mixed case username Standard user and Standard password
    And I log out user

  @TC.120661 @bus @log_in_screen
  Scenario: 120661 Hipaa user log into BUS with upper/mixed case username
    When I navigate to Hipaa subdomain user login page
    Then I log into Hipaa subdomain with uppercase username Hipaa user and Hipaa password
    And I log out user
    Then I log into Hipaa subdomain with mixed case username Hipaa user and Hipaa password
    And I log out user
