Feature: Restore all files

  Background:
    Given I log in freyja as MozyPro user

  @TC.121288 @freyja @restore_all_files @archive_restore
  Scenario: MozyPro user do restore all files in Freyja (archive)
    When I restore all files from the details panel
    And I go through restore all files restore wizard
      | restore name     | restore type |
      | restore all files| archive      |
    When I navigate to menu-user section from freyja page
    And I select event history from user menu section
    Then the restore is Processing

  @TC.121288 @freyja @restore_all_files @restore_manager
  Scenario: MozyPro user do restore all files in Freyja (restore manager)
    When I restore all files from the details panel
    And I go through restore all files restore wizard
      | restore name     | restore type |
      | restore all files| fryr         |
    When I navigate to menu-user section from freyja page
    And I select event history from user menu section
    Then the restore is Ready for Download

  @TC.121288 @freyja @restore_all_files @media_restore
  Scenario: MozyPro user do restore all files in Freyja (media)
    When I restore all files from the details panel
    And I go through restore all files restore wizard
      | restore name     | restore type |
      | restore all files| media        |
    When I navigate to menu-user section from freyja page
    And I select event history from user menu section
    Then the restore is In Progress
