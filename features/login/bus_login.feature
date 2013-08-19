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