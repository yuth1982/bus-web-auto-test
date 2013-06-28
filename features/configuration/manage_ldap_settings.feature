Feature: Manage Horizon related settings

  As an Mozy administrator
  I want to leverage Horizon service as a 3rd party SSO solution
  So that my users can be authenticated using domain credentials

  Background:
    Given I log in bus admin console as administrator
    When I act as partner by:
      | email                       |
      | congshanl+usersync@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page

  @TC.17476 @TC.17477 @bus @2.1 @direct_ldap_integration @authentication_migration
  Scenario: Successfully verify 'Test Connection' button should work with valid host
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | 10.135.16.154        | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then AD server test connection message should be Test passed. Successfully connected to 10.135.16.154 on port 389 using No SSL.
    And I save the Connection Settings information
    Then server connection settings information should include
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | 10.135.16.154        | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com|  QAP@SSw0rd   |

  @TC.17825 @bus @2.1 @direct_ldap_integration @authentication_migration
  Scenario: 'Test Connection' should report invalid credentials error
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| 1hkc9ad@qa5.mozyops.com| daf145gvi    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then AD server test connection message should be Test failed. Error: Could not connect to the AD server. Reason: BIND failed. Please verify you entered the correct BIND settings.

  @TC.17478 @bus @2.1 @direct_ldap_integration @authentication_migration
  Scenario: Successfully verify 'Test Connection' button should work with valid domain name input
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then AD server test connection message should be Test passed. Successfully connected to ad01.qa5.mozyops.com on port 389 using No SSL.
    And I save the Connection Settings information
    Then server connection settings information should include
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com|  QAP@SSw0rd   |


  @TC.17479 @bus @2.1 @direct_ldap_integration @authentication_migration
  Scenario: Host input should reject invalid parameters
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | 10.34.9.             | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then The save error message should be:
      | Save failed  |
      | Invalid data.|

  @TC.17480 @bus @2.1 @direct_ldap_integration @authentication_migration
  Scenario: Port input should reject invalid parameters
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 0    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then The save error message should be:
      | Save failed  |
      | Invalid data.|

  @TC.17482 @bus @2.1 @direct_ldap_integration @authentication_migration
  Scenario: Base Tree should reject invalid empty inputs
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  |                           | leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then AD server test connection message should be Test failed. Error: AD base DN is not provided.

  @TC.17484 @bus @2.1 @direct_ldap_integration @authentication_migration
  Scenario: Certificate should only be enabled with SSL enabled
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I select Protocol as No SSL
    Then certificate text field is disabled
    And I select Protocol as StartTLS
    Then certificate text field is enabled

  @TC.17486 @TC.17487 @bus @2.1 @direct_ldap_integration @authentication_migration
  Scenario: Authentication tab should be able to save inputs correctly
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click SAML Authentication tab
    And I clear SAML Authentication information exists
    And I input SAML authentication information
      | URL                        | Endpoint                    | Certificate      |
      |sso.connect.pingidentity.com|sso.connect.pingidentity.com | abcdefghijkl     |
    And I save the SAML Authentication information
    Then SAML authentication information should include
      | URL                        | Endpoint                    | Certificate      |
      |sso.connect.pingidentity.com|sso.connect.pingidentity.com | abcdefghijkl     |