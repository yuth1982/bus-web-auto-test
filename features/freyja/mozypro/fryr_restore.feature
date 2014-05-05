Feature: Fryr Restore

  Background:
    Given I log in freyja as MozyPro user

  @TC.121294 @freyja @restore_manager
  Scenario: MozyPro user do fryr restore
    When I restore all files from the details panel
    And I go through restore wizard
      | restore name     | restore type |
      | restore all files| fryr         |
    When I navigate to menu-user section from freyja page
    And I select event history from user menu section
    Then the restore is Ready for Download
