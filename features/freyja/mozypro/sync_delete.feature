Feature: Delete files in Sync

  Background:
    Given I log in freyja as MozyPro user

  @TC.121289 @freyja @delete
  Scenario: MozyPro user delete files in Sync
    When I go to Synced
    And I view Actions pane from synced
    And I delete one file from actions pane
    Then file is Deleted
