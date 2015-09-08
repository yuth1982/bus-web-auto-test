Feature: As a Mozy Admin, I should be able to add new sync version and manage the version.

  Background:
    Given I log in bus admin console as administrator

  @TC.131353 @bus @regression
  Scenario: 131353 Create a new mozy sync version and in Mozy Inc
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win-sync | true          |
    And I delete version 10.10.10.10 if it exists
    And I navigate to Create New Version section from bus admin console page
    And I add a new client version:
      | name                | platform | version number | notes                                              |
      | WinSyncTestVersion  | win-sync | 10.10.10.10    | This is a test version for BUS version management. |
    Then the client version should be created successfully

  @TC.131358 @bus @regression
  Scenario: 131358 Sync client version can be listed in List Version view
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win-sync | false         |
    Then I should not see version 10.10.10.10 in version list
    When I list versions for:
      | platform | show disabled |
      | win-sync | true          |
    Then I can find the version info in versions list:
      | Version     | Platform  | Name               | Status   |
      | 10.10.10.10 | win-sync  | WinSyncTestVersion | disabled |

  @TC.131359 @TC.131360 @bus @regression
  Scenario: 131359 131360 Linux client can be uploaded successfully for Mozy, Inc.(MozyEnterprise/MozyPro root partner)
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win-sync | true          |
    And I view version details for 10.10.10.10
    And I click Brandings tab of version details
    And I upload executable FakeWinSyncClient.exe for partner Mozy, Inc.
    And I upload executable FakeWinSyncClient.exe for partner MozyPro
    And I upload executable FakeWinSyncClient.exe for partner MozyEnterprise
    And I save changes for the version
    Then version info should be changed successfully
    And the download link for partner Mozy, Inc. should be generated
    And the download link for partner MozyPro should be generated
    And the download link for partner MozyEnterprise should be generated
    And I click General tab of version details
    And I change version status to enabled
    Then version info should be changed successfully
    When I list versions for:
      | platform | show disabled |
      | win-sync | false         |
    Then I can find the version info in versions list:
      | Version     | Platform  | Name               | Status  |
      | 10.10.10.10 | win-sync  | WinSyncTestVersion | enabled |

  @TC.131371 @bus @regression
  Scenario: 131371 Create Auto upgrade rule for Sync client
    When I act as partner by:
      | name    | including sub-partners |
      | MozyPro | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinSyncTestVersion if it exists
    Then I add a new upgrade rule:
      | version name        | Req? | On? | min version | max version | Install CMD  |
      | WinSyncTestVersion  | N    | Y   | 0.0.0.1     | 0.0.0.2     | "%1" /silent |
    And I stop masquerading as sub partner
    When I search partner by:
      | name                                                     | including sub-partners |
      | Internal Mozy - MozyPro with edit user group capability  | yes                    |
    And I view partner details by Internal Mozy - MozyPro with edit user group capability
    And I record the MozyPro partner name Internal Mozy - MozyPro with edit user group capability and admin name Admin Automation
    And I get the admin id from partner details
    When I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.131371.User | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.131371.User
    And I got client config for the user machine:
      | user_name                   | machine    | platform | codename | version | arch |
      | <%=@new_users.first.email%> | plop000001 | win      | mozypro  | 0.0.0.2 | x86  |
    And client config should contains:
      | update-url                                    |
      | /downloads/mozypro-sync-10_10_10_10-XXXXX.exe |
    And I delete user

  @TC.132043 @bus @regression
  Scenario: 132043 Partner without Edit User Group capability -- Auto update will inherit parent upgrade rules
    When I act as partner by:
      | name    | including sub-partners |
      | MozyPro | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinSyncTestVersion if it exists
    Then I add a new upgrade rule:
      | version name        | Req? | On? | min version | max version | Install CMD  |
      | WinSyncTestVersion  | N    | Y   | 0.0.0.1     | 0.0.0.2     | "%1" /silent |
    And I stop masquerading as sub partner

    When I search partner by:
      | name                                                   | including sub-partners |
      | Internal Mozy - MozyPro no edit user group capability  | yes                    |
    And I view partner details by Internal Mozy - MozyPro no edit user group capability
    And I record the MozyPro partner name Internal Mozy - MozyPro no edit user group capability and admin name Admin Automation
    And I get the admin id from partner details
    When I act as newly created partner
    And I navigate to Edit Client Version section from bus admin console page
    Then upgrade rule should contains:
      | Windows Sync Default: |
      | auto-update           |
    When I add new user(s):
      | name           | storage_type | storage_limit | devices | enable_stash |
      | TC.132043.User | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.132043.User
    And I got client config for the user machine:
      | user_name                   | machine    | platform | codename | version | arch |
      | <%=@new_users.first.email%> | plop000001 | win      | mozypro  | 0.0.0.2 | x86  |
    And client config should contains:
      | update-url                                    |
      | /downloads/mozypro-sync-10_10_10_10-XXXXX.exe |
    And I delete user

  @TC.132044 @bus @regression
  Scenario: 132044 Partner without Edit User Group capability -- Sync Default is not displayed if it's Sync disabled
    When I act as partner by:
      | name                                       | including sub-partners |
      | Internal Mozy - MozyPro with sync disabled | yes                    |
    And I navigate to Edit Client Version section from bus admin console page
    Then there is no Sync rule in client rule fieldset

  @TC.132030 @bus @regression
  Scenario: 132030 Upgrade to: Product partner can list the inherited version if not branded
    When I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinSyncTestVersion if it exists
    Then I add a new upgrade rule:
      | version name        | Req? | On? | min version | max version | Install CMD  |
      | WinSyncTestVersion  | N    | N   | 0.0.0.1     | 0.0.0.2     | "%1" /silent |
    And I stop masquerading as sub partner

    When I act as partner by:
      | name                                           | including sub-partners |
      | Internal Mozy - MozyEnterprise product partner | yes                    |
    And I navigate to Edit Client Version section from bus admin console page
    Then Client Version Rules should include rule:
      | Update To                | User Group      | Current Version         | OS  | Required | Install Command | Options |
      | Windows Sync 10.10.10.10 | All User Groups | 0.0.0.1 through 0.0.0.2 | Any | No       | "%1" /silent    |         |
    And there is version Windows Sync 10.10.10.10 in Update to list

  @TC.131403 @bus @regression
  Scenario: 131403 Sync client can not be downloaded if sync is not enabled
    When I act as partner by:
      | name                                       | including sub-partners |
      | Internal Mozy - MozyPro with sync disabled | yes                    |
    And I navigate to Download MozyPro Client section from bus admin console page
    Then I should not see Sync Clients download info

  @TC.131405 @bus @regression
  Scenario: 131405 Product partner can download sync executable upload in Mozy,Inc if it has no branded executables
    When I act as partner by:
      | name                                           | including sub-partners |
      | Internal Mozy - MozyEnterprise product partner | yes                    |
    And I navigate to Download * Client section from bus admin console page
    Then I can find client download info of platform Windows in Sync Clients part:
      | WinSyncTestVersion |
    When I view Details for client WinSyncTestVersion
    Then I should see download link for MozyEnterprise-sync-10_10_10_10
    When I clear downloads folder
    And I click download link for MozyEnterprise-sync-10_10_10_10
    Then client started downloading successfully
    When I wait for client fully downloaded
    Then the downloaded client should be same as the uploaded file FakeWinSyncClient.exe

  @TC.131357 @bus @regression
  Scenario: 131357 Sync client version can be deleted
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win-sync | true          |
    And I delete version 10.10.10.10 if it exists
    And I should not see version 10.10.10.10 in version list
