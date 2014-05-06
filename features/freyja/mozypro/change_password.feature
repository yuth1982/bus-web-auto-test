Feature: Login to Freyja

  Background:
    Given I log in freyja as MozyPro user

  @TC.121282 @freyja @change_password_mozypro
  Scenario: MozyPro user change password through Freyja
    When I navigate to menu-user section from freyja page
    And I change password from test1234 to test123
    Then Password changed message should be Your password has been changed.
    And I change password successfully
    When I navigate to menu-user section from freyja page
    And I change password from test123 to test1234
    Then Password changed message should be Your password has been changed.
    And I change password successfully
