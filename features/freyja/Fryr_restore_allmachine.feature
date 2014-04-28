Feature: Fryr restore

  Background:
    #Given I have logged in as a existing mozy pro user
     Given I log in freyja as MozyPro user
  @121459
  Scenario: 121459 Use Fryr to restore all files for a single computer
    When I select the devices tab
    And I open the actions panel
    And I select the restore all files link
    #And I choose my machine
    And I fill out the restore wizard
      | restore_format | incl_deleted |
      | dl_mgr         | true         |
    #And I select event history from the user account menu
    #Then my restore is complete