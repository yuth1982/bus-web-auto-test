Feature: Instant Download

  Background:
    Given I have login freyja as OEM user

  @oem_instant_download_Sync_file
  Scenario: OEM user instant download one file in Freyja
    When I select the Synced tab
    And I choose one file
    And I open Actions panel
    And I click download now
    When I select options menu
    And I select event history
    Then instant download is Completed

  @oem_instant_download_Sync_folder
  Scenario: OEM user instant download one folder in Freyja
    When I select the Synced tab
    And I choose one folder
    And I open Actions panel
    And I click download now
    When I select options menu
    And I select event history
    Then instant download is Completed