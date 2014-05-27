Feature: File Versions

  Background:
    Given I have login freyja as home user

  @freyja  @home  @home_view_sync_file_versions
  Scenario: home user view file versions in Sync container
    When I select the Synced tab
    And I choose one file with versions
    And I open Actions panel
    And I click Show Versions
    Then file versions are displayed
    When I select options menu
    And I logout
