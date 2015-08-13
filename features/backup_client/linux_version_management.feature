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
    Then version info should be changed successfully
    And the download link for partner Mozy, Inc. should be generated


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





