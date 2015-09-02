Feature: As a Mozy Admin, I should be able to add new linux version and manage the version.

  Background:
    Given I log in bus admin console as administrator

  # It takes about 51s in qa6 if the version is not existed
  # It takes about 13m25s in qa6 if the version has executable uploaded (It will iterate all product partner when deleting a version with executable)
  @TC.122460 @bus @regression
  Scenario: 122460 create a new linux version in Mozy Inc
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | true          |
    And I delete version 10.10.10.10 if it exists
    And I navigate to Create New Version section from bus admin console page
    And I add a new client version:
      | name              | platform | arch    | version number | notes                                              |
      | LinuxTestVersion  | linux    | deb-32  | 10.10.10.10    | This is a test version for BUS version management. |
    Then the client version should be created successfully

  #It takes about 2m16s in qa6
  @TC.122465 @bus @regression
  Scenario: 122465 Linux client version can be listed in List Version view
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | false         |
    Then I should not see version 10.10.10.10 in version list
    When I list versions for:
      | platform | show disabled |
      | linux    | true         |
    Then I can find the version info in versions list:
      | Version     | Platform  | Name             | Status   |
      | 10.10.10.10 | linux     | LinuxTestVersion | disabled |

  #It sometimes fail in qa6, bus will return 500 error (timeout) in this section, while the client is uploaded successfully
  #It takes 2m3s in staging
  @TC.123296 @bus @regression
  Scenario: 123296 Linux client can be uploaded successfully for Mozy, Inc.
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | true         |
    And I view version details for 10.10.10.10
    And I click Brandings tab of version details
    And I upload executable FakeLinuxClient.deb for partner Mozy, Inc.
    And I upload executable FakeLinuxClient.deb for partner MozyPro
    And I upload executable FakeLinuxClient.deb for partner MozyEnterprise
    And I save changes for the version
    Then version info should be changed successfully
    And the download link for partner Mozy, Inc. should be generated
    And the download link for partner MozyPro should be generated
    And the download link for partner MozyEnterprise should be generated

  #It sometimes fails in qa6, bus will return 500 error (timeout) in this section, while the version status will changed to enabled
  #It takes 2m3s in staging
  @TC.122462 @bus @regression
  Scenario: 122462 Linux client version can be enabled
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | true          |
    And I view version details for 10.10.10.10
    And I click General tab of version details
    And I change version status to enabled
    And version info should be changed successfully
    When I list versions for:
      | platform | show disabled |
      | linux    | false         |
    Then I can find the version info in versions list:
      | Version     | Platform  | Name             | Status  |
      | 10.10.10.10 | linux     | LinuxTestVersion | enabled |


  # Precondition: (@TC.122544) No auto rule or auto rule defined in MozyPro is 10.10.10.10
  #
  @TC.123298 @bus @regression
  Scenario: 123298 Linux client can be downloaded successfully for none product partner
    When I act as partner by:
      | name                                                    | including sub-partners |
      | Internal Mozy - MozyPro with edit user group capability | yes                    |
    And I navigate to Download MozyPro Client section from bus admin console page
    Then I can find client download info of platform Linux in Backup Clients part:
      | 32 bit .deb: MozyPro LinuxTestVersion |
    When I clear downloads folder
    And I click download link for MozyPro LinuxTestVersion
    Then client started downloading successfully
    And I wait for client fully downloaded
    Then the downloaded client should be same as the uploaded file FakeLinuxClient.deb

  @TC.131413 @bus @regression
  Scenario: 131413 Linux client can not be downloaded if the partner don't have server license
    When I act as partner by:
      | name                                                  | including sub-partners |
      | Internal Mozy - MozyEnterprise without server license | yes                    |
    And I navigate to Download MozyEnterprise Client section from bus admin console page
    Then I should not see Linux download info


  # Only automate part of 123391.
  # Disabling all linux version (except one only have Mozy,Inc uploaded) is not a necessary scenario in production
  @TC.123391 @bus @regression
  Scenario: 123391 bds linux client can be download successfully for MozyOEM partner
    When I navigate to Download BDS Remote Backup Client section from bus admin console page
    Then I can find client download info of platform Linux in Backup Clients part:
      | 32 bit .deb: LinuxTestVersion |
    When I clear downloads folder
    And I view Details for client LinuxTestVersion
    And I click download link for bds-deb-32-10_10_10_10
    Then client started downloading successfully
    And I wait for client fully downloaded
    Then the downloaded client should be same as the uploaded file FakeLinuxClient.deb
    
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | no                     |
    And I navigate to Download BDS Remote Backup Client section from bus admin console page
    Then I can find client download info of platform Linux in Backup Clients part:
      | 32 bit .deb: BDS Remote Backup LinuxTestVersion |
    When I clear downloads folder
    And I view Details for client BDS Remote Backup LinuxTestVersion
    And I click download link for bds-deb-32-10_10_10_10
    Then client started downloading successfully
    And I wait for client fully downloaded
    Then the downloaded client should be same as the uploaded file FakeLinuxClient.deb

  @TC.123297 @bus @regression
  Scenario: 123297 Check download links for bds linux client
    When I navigate to Download BDS Remote Backup Client section from bus admin console page
    And I clear downloads folder
    And I visit BUS download link for bds-deb-32setup.deb
    Then client started downloading successfully
    And I wait for client fully downloaded
    Then the downloaded client should be same as the uploaded file FakeLinuxClient.deb

  @TC.124097 @bus @regression
  Scenario: 124097 VMBU Client can be downloaded
    When I act as partner by:
      | name                                                    | including sub-partners |
      | Internal Mozy - MozyPro with edit user group capability | yes                    |
    And I navigate to Download MozyPro Client section from bus admin console page
    Then I should see download link for Download MozyPro vSphere Backup Software
    When I clear downloads folder
    And I click download link for Download MozyPro vSphere Backup Software
    Then client started downloading successfully

  @clean_up
  Scenario: clean up all linux test versions and rules
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | true          |
    And I delete version 10.10.10.10 if it exists
