Feature: Archive Restore

  Background:
    Given I log in freyja as MozyPro user

  @TC.121293 @freyja @restore_one_file_archive_restore
  Scenario: MozyPro user restore one file in Freyja (archive)
    When I go to Devices
    And I choose one file from backup
    And I view Actions pane from backup
    And I choose Large Download Options
    And I go through Large Download Options restore wizard
      | restore name     | restore type |
      | restore one file | archive      |
    When I navigate to menu-user section from freyja page
    And I select event history from user menu section
    Then the restore is Processing

  @TC.121293 @freyja @restore_one_folder_archive_restore
  Scenario: MozyPro user restore one folder in Freyja (archive)
    When I go to Devices
    And I choose one folder from backup
    And I view Actions pane from backup
    And I choose Large Download Options
    And I go through Large Download Options restore wizard
      | restore name       | restore type |
      | restore one folder | archive      |
    When I navigate to menu-user section from freyja page
    And I select event history from user menu section
    Then the restore is Processing
