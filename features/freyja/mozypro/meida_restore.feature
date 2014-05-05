Feature: Meida Restore

  Background:
    Given I log in freyja as MozyPro user

  @media_restore
  Scenario: MozyPro user do media restore
    When I restore all files from the details panel
    And I go through restore wizard
      | restore name     | restore type |
      | restore all files| media        |
    When I navigate to menu-user section from freyja page
    And I select event history from user menu section
    Then the restore is In Progress
