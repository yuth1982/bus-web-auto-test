Feature: Upload and delete files in Sync
  Background:
    Given I have login freyja as ent user

  @TC.121718 @TC.121720 @freyja @freyja_smoke  @ent  @ent_upload_delete_one_file_Sync @ent_smoke
  Scenario: MozyEnterprise user upload and delete one file in Sync
    When I select the Synced tab
    And I open Actions panel
    And I click Upload Files
    And I upload one file
    Then one file is uploaded successfully
    When I select options menu
    And I logout

