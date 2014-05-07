Feature: Instant Download

  Background:
    Given I log in freyja as MozyPro user

  @TC.121292 @freyja @instant_download
  Scenario: MozyPro user instant download one file in Freyja
    When I choose one file from backup
    And I download from the backup details pane
    When I navigate to menu-user section from freyja page
    And I select event history from user menu section
    Then instant download is Completed
