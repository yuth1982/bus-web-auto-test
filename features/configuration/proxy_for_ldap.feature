Feature: Proxy for LDAP queries

  As the Operations/Security team
  We want outbound LDAP requests to go through a dynamically-updated proxy server
  So that we don't have to punch holes in our firewall for every FedId customer

  Background:
    Given I log in bus admin console as administrator

  @FID11.1006 @TC.19203
  Scenario: [Update whitelists][P]The whitelist(sockd.conf) add 1 item after adding 1 new IP/port in the UI
    When I act as partner by:
      | email                          |
      | congshanl+fedid+proxy@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    And I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | @host_address        | No SSL   |          | @port  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    And I get the full whitelist into new_whitelist
    Then The new Server Host and Port are added to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed