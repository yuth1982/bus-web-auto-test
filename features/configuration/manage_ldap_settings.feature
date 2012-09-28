Feature: Manage Horizon related settings

  As an Mozy administrator
  I want to leverage Horizon service as a 3rd party SSO solution
  So that my users can be authenticated using domain credentials

  Background:
    Given I log in bus admin console as administrator
    And I act as the partner by congshanl+usersync@mozy.com on admin details panel
    And I navigate to Authentication Policy section from bus admin console page

  @TC.17476 @TC.17477
  Scenario: Successfully verify 'Test Connection' button should work with valid host
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I Test Connection for AD
    Then AD server test connection message should be Test passed. Successfully connected to ad01.qa5.mozyops.com on port 389 using No SSL.
    And I save the Connection Settings information
    Then server connection settings information should include
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com|  QAP@SSw0rd   |

  @TC.17825
  Scenario: 'Test Connection' should report invalid credentials error
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| 1hkc9ad@qa5.mozyops.com| daf145gvi    |
    And I Test Connection for AD
    Then AD server test connection message should be Test failed. Error: Could not connect to the AD server. Reason: BIND failed. Please verify you entered the correct BIND settings.
