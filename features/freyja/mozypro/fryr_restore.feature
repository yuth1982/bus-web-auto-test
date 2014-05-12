Feature: Fryr Restore

  Background:
    Given I log in freyja as MozyPro user

  @TC.121294 @freyja @restore_one_file_restore_manager
  Scenario: MozyPro user restore one file in Freyja (fryr)
    When I go to Devices
    And I choose one file from backup
    And I view Actions pane from backup
    And I choose Large Download Options
    And I go through Large Download Options restore wizard
      | restore name     | restore type |
      | restore all files| fryr         |
    When I navigate to menu-user section from freyja page
    And I select event history from user menu section
    Then the restore is Ready for Download

  @TC.121294 @freyja @restore_one_folder_restore_manager
  Scenario: MozyPro user restore one folder in Freyja (fryr)
    When I go to Devices
    And I choose one folder from backup
    And I view Actions pane from backup
    And I choose Large Download Options
    And I go through Large Download Options restore wizard
      | restore name     | restore type |
      | restore all files| fryr         |
    When I navigate to menu-user section from freyja page
    And I select event history from user menu section
    Then the restore is Ready for Download
