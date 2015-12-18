Feature: View machine manifest, logfile

  Background:
    Given I log in bus admin console as administrator

  @TC.869 @bus @machines_sync @tasks_p2 @smoke
  Scenario: 869 View a manifest normal
    When I navigate to bus admin console login page
    And I log in bus admin console with user name mozybus+backupsrestores@gmail.com and password default password
    When I search machine by:
      | machine_name   |
      | CNENCHENC33L1C |
    And I view machine details for mozybus+backup+restore@emc.com
    And I click View from machines details section
    And I navigate to new window
    Then the manifest window title should be Dont Edit_backup_restore_history - Manifest for CNENCHENC33L1C
    And action links in the manifest will be
      | show deleted files | show real filenames | open raw | reload |
    And manifest content will include
      """
      backup time    | mtime          |  file size |  comp size | patch size | hash
      """

  @TC.870 @bus @machines_sync @tasks_p2 @smoke
  Scenario: 870 View a manifest raw
    When I navigate to bus admin console login page
    And I log in bus admin console with user name mozybus+backupsrestores@gmail.com and password default password
    When I search machine by:
      | machine_name   |
      | CNENCHENC33L1C |
    And I view machine details for mozybus+backup+restore@emc.com
    And I delete file manifest-mozybusbackuprestore@emc.com-CNENCHENC33L1C.txt if exist
    And I click Raw from machines details section
    Then the manifest file is downloaded
      | file name                                                |
      | manifest-mozybusbackuprestore@emc.com-CNENCHENC33L1C.txt |
    And manifest manifest-mozybusbackuprestore@emc.com-CNENCHENC33L1C txt file should include:
      """
      _hash|89047df06bfabd45fa8af58f28c995d69aeb5dcc
      """

  @TC.2059 @bus @machines_sync @tasks_p2 @smoke
  Scenario: 2059 View the Logfile in BUS
    When I act as partner by:
      | email                             |
      | mozybus+backupsrestores@gmail.com |
    When I search machine by:
      | machine_name   |
      | CNENCHENC33L1C |
    And I view machine details for mozybus+backup+restore@emc.com
    And I delete file client-mozybusbackuprestore@emc.com-CNENCHENC33L1C.log if exist
    And I click View Logfile from machines details section
    Then the Logfile file is downloaded
      | file name                                              |
      | client-mozybusbackuprestore@emc.com-CNENCHENC33L1C.log |
    And File size should be greater than 0
    Then I delete the newly downloaded file

  # using fixed data partner id: 3431128,  partner: freyatest01[Do Not Edit]
  @TC.122221 @bus @machines_sync @tasks_p2 @smoke
  Scenario: 122221 Order Restore dvd
    When I search user by:
     | keywords                    |
     | mozybus+freyatest01@emc.com |
    And I view user details by mozybus+freyatest01@emc.com
    When I click restore Files folder icon for device CNENCHENC33L1C
    And I navigate to new window
    Then I have login freyja from BUS
    When I select the Devices tab
    And I choose one device
    And I click restore all files in the detail panel
    And I fill out the restore all files wizard
      | restore_name     | restore_type |
      | archive_all_file | media        |
    When I select options menu
    And I select event history
    Then this restore is In Progress
    When I close new window
    And I view machine CNENCHENC33L1C details from user details section
    Then Restores table first record will display as:
      | ID                       | Date/Time Requested | Date/Time Finished | Files Retrieved | Size  | Status / Downloads                       |
      | <%=@restore.restore_id%> | today               | today              | 1 / 1           | 1 DVD | Retrieved files; preparing to burn DVDs. |



